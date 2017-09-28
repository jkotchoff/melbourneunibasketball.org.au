class StripeChargesService
  DEFAULT_CURRENCY = 'aud'.freeze

  def initialize(member)
    @member = member
  end

  def call
    return true if @member.amount_paid.zero?

    Stripe::Charge.create(
      customer: stripe_customer.id,
      source:   stripe_card.id,
      amount:   @member.amount_paid * 100,  # convert to cents
      currency: 'aud'
    )
  end

  def stripe_customer
    if @member.stripe_customer_id
      @customer ||= Stripe::Customer.retrieve(@member.stripe_customer_id)
    else
      Stripe::Customer.create(email: @member.email).tap do |customer|
        @member.stripe_customer_id = customer.id
      end
    end
  end

  def stripe_card
    @card_id ||= stripe_customer.sources.create(source: generate_token)
  end

  def generate_token
    Stripe::Token.create(
      card: {
        number: @member.card_number.strip,
        exp_month: @member.card_expiry_month.to_i,
        exp_year: @member.card_expiry_year.to_i,
        cvc: @member.card_cvv.strip
      }
    ).id
  end

end
