class MemberMailer < ActionMailer::Base
  default from: "Melbourne University Basketball Club <treasurer@melbourneunibasketball.org.au>"

  def bank_transfer_notification(member)
    recipient = "#{member.name} <#{member.email}>"
    # from       "Melbourne University Basketball Club"
    # subject    "Please activate your MUBC membership with a bank transfer"
    # sent_on    Time.now
    @member = member
    mail to: recipient, subject: "Please activate your MUBC membership with a bank transfer" 
  end


  def signup_notification(member)
    recipient = "#{member.name} <#{member.email}>"
    # from       "Melbourne University Basketball Club"
    # subject    "Please activate your MUBC membership with a bank transfer"
    # sent_on    Time.now
    @name = member.name
    @year = member.created_at.year
    @payment_method = member.payment_method
    mail to: recipient, subject: "Your MUBC membership payment for #{@year} has been acknowledged" 
  end

end
