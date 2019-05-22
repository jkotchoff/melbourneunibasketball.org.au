class StripeRefundService
  def initialize(member)
    @member = member
    @fee = @member.amount_paid
  end

  def call
    Stripe::Refund.create({
      charge: charge.id,
    })
    @member.update_attributes(
      amount_paid: 0,
      payment_confirmed: false,
      payment_acknowledgement: "$#{@fee} Stripe fee was refunded"
    )
  rescue Exception => e
    @error = e
  end

  def success_message
    "#{@member.name}'s $#{@fee} membership fee has been refunded"
  end

  def error_message
    @error
  end

private
  def charge
    customer.charges.data.last
  end

  def customer
    Stripe::Customer.retrieve(@member.stripe_customer_id)
  end
end
