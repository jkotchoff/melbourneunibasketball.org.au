class MemberMailer < ActionMailer::Base
  default from: "Melbourne University Basketball Club <treasurer@melbourneunibasketball.org.au>"

  def signup_notification(member)
    recipient = "#{member.name} <#{member.email}>"
    # from       "Melbourne University Basketball Club"
    # subject    "Please activate your MUBC membership with a bank transfer"
    # sent_on    Time.now
    @name = member.name
    @year = member.created_at.year
    @eligibility_clause = member.eligibility_clause
    @amount_paid = member.amount_paid
    @payment_method = member.payment_method
    mail to: recipient, bcc: "treasurer@melbourneunibasketball.org.au", subject: "MUBC  #{@year} membership payment for #{member.name} has been acknowledged"
  end

end
