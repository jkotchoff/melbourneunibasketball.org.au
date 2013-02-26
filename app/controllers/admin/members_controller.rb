class Admin::MembersController < Admin::BaseController
  
  before_filter :require_superadmin
  
  def index
    @members = Member.current.paid
  end
  
  def pending
    @unpaid_members = Member.current.unpaid
  end
  
  def csv_export
    report_path = MemberDatabase.export_csv
    send_file report_path, :type => 'text/csv; charset=iso-8859-1; header=presen', :disposition => 'attachment'
  end
  
  def acknowledge_payment
    @member = Member.find(params[:id])
    @member.update_attributes(payment_confirmed: true, payment_acknowledgement: params[:payment_acknowledgement])
    MemberMailer.signup_notification(@member).deliver
    redirect_to pending_admin_members_path, flash: {notice: "Payment acknowledged for #{@member.name}"}
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])

    if @member.update_attributes(params[:member])
      redirect_to [:admin, @member], notice: "#{@member.name} was successfully updated."
    else
      render action: "edit"
    end
  end
  
  def show
    @member = Member.find(params[:id])
  end
    
  def destroy
    @member = Member.find(params[:id])
    member_name = @member.name
    @member.destroy

    redirect_to pending_admin_members_path, notice: "#{member_name} was destroyed."
  end

end
