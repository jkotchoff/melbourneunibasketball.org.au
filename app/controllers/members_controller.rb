class MembersController < ApplicationController
  before_filter :assigns_gateway
 
  include ActiveMerchant::Billing
  include PaypalExpressHelper
 
  def new
    @member = Member.new
    #@member.are_you_a_new_member = 1
    @member.payment_method = :paypal
    #@member.representative_player = 0
  end
 
  def create
    @member = Member.new(params[:member])

    if @member.save
      redirect_to @member
    else
      render action: "new"
    end
=begin
    #TODO: store member object with a 'paypal' status
    total_as_cents, setup_purchase_params = get_setup_purchase_params 140, request
    setup_response = @gateway.setup_purchase(total_as_cents, setup_purchase_params)
    redirect_to @gateway.redirect_url_for(setup_response.token)
=end
  end

  def review_paypal_payment
    #TODO: instantiate @member
    
    if params[:token].nil?
      redirect_to membership_path, flash: {error: 'Woops! Something went wrong!'} 
      return
    end
 
    gateway_response = @gateway.details_for(params[:token])
 
    unless gateway_response.success?
      redirect_to membership_path, flash: {error: "Sorry! Something went wrong with the Paypal purchase. Here's what Paypal said: #{gateway_response.message}"} 
      return
    end
    
    @member = Member.new #TODO
    
    @member.postal_address = gateway_response.address
    @member.email = gateway_response.email
    # gateway_response.token
    # gateway_response.payer_id
 
    # @order_info = get_order_info gateway_response, @member
  end
   
  private
    def assigns_gateway
      @gateway ||= PaypalExpressGateway.new(
        :login => ENV['PAYPAL_LOGIN'],
        :password => ENV['PAYPAL_PASSWORD'],
        :signature => ENV['PAYPAL_SIGNATURE']
      )
    end
end