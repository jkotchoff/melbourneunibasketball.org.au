class Admin::MembersController < Admin::BaseController

  before_action :require_superadmin, only: [:acknowledge_payment, :edit, :update, :destroy, :refund]

  def index
    @selected_year = params[:year].present? ? params[:year].to_i : Date.today.year
    @members = Member.not_expiring_soon(@selected_year).order(:given_name)
    @refunded_members = Member.for_year(@selected_year).refunded.order(:given_name)
    @expiring_members = Member.expiring_soon(@selected_year).order(:given_name)
    @member_count = @members.length
    males = @members.select{|m| m.gender == "Male"}
    females = @members.select{|m| m.gender == "Female"}
    @males_percentage = (males.length / @member_count.to_f * 100).to_i rescue 0
    @females_percentage = (females.length / @member_count.to_f * 100).to_i rescue 0
    @average_age = @members.collect(&:age).mean rescue "N/A"
    @average_male_age = males.collect(&:age).mean rescue "N/A"
    @average_female_age = females.collect(&:age).mean rescue "N/A"
    @total_money_collected = Member.funds_raised(@selected_year)
    @available_membership_years = Member.available_membership_years
  end

  def csv_export
    report_path = MemberDatabase.export_csv
    send_file report_path, :type => 'text/csv; charset=iso-8859-1; header=presen', :disposition => 'attachment'
  end

  def uniforms_export
    report_path = MemberDatabase.uniforms_csv
    send_file report_path, :type => 'text/csv; charset=iso-8859-1; header=presen', :disposition => 'attachment'
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])

    if @member.update(member_params)
      redirect_to [:admin, @member], notice: "#{@member.name} was successfully updated."
    else
      render action: "edit"
    end
  end

  def show
    @member = Member.find(params[:id])
  end

  def refund
    @member = Member.find(params[:id])

    stripe_service = StripeRefundService.new(@member)
    if stripe_service.call
      redirect_to [:admin, @member], notice: stripe_service.success_message
    else
      flash.now[:error] = stripe_service.error_message
      render action: "show"
    end
  end

  def destroy
    @member = Member.find(params[:id])
    member_name = @member.name
    @member.destroy

    redirect_to admin_members_path, notice: "#{member_name} was destroyed."
  end

end
