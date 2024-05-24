class MembersController < ApplicationController
  before_action :load_sidebar

  def index
    render_page(Page::CONTACT_JOIN_THE_CLUB)
  end

  def new
    @member = Member.new
    @member.payment_method = :paypal
  end

  def create
    @member = Member.new(member_params.merge(payment_method: "stripe"))
    stripe_service = StripeChargesService.new(@member)

    if @member.valid? && !duplicate_signup?(@member) && stripe_service.call
      @member.save
      MemberMailer.signup_notification(@member).deliver
      redirect_to thankyou_member_path(@member)
    else
      render action: "new"
    end
  rescue Stripe::CardError => exception
    flash.now[:error] = exception.message
    render action: "new"
  end

  def mubc_account_details
    @member = Member.find(params[:id])
    if @member.payment_confirmed?
      redirect_to membership_path, flash: {error: "Whoops.. Seems like this member is already paid up. We wouldn't want to charge them twice!"}
    end
  end

  def thankyou
    @member = Member.find(params[:id])
  end

private
  def duplicate_signup?(member)
    existing_member = Member.where("lower(email) = ?", member.email).where(amount_paid: member.amount_paid)
                            .where("created_at > ?", 1.week.ago).exists?
    if existing_member
      flash.now[:error] = "You already signed up for this year successfully, did you not receive a confirmation message? You can email treasurer@melbourneunibasketball.org.au if you have any questions."
    end
    existing_member
  end


  def load_sidebar
    @left_sidebar = "sidebars/members"
  end

end
