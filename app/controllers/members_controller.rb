class MembersController < ApplicationController
  before_action :load_sidebar

  def index
    render_page(Page::CONTACT_JOIN_THE_CLUB)
  end

  def uniforms
    render_page(Page::CONTACT_UNIFORMS)
  end

  def documents_and_forms
    render_page(Page::CONTACT_DOCUMENTS_AND_FORMS)
  end

  def new
    @member = Member.new
    @member.payment_method = :paypal
  end

  def create
    @member = Member.new(member_params.merge(payment_method: "stripe"))
    stripe_service = StripeChargesService.new(@member)
    if @member.valid? && stripe_service.call
      @member.save
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
  def load_sidebar
    @left_sidebar = "sidebars/members"
  end

end
