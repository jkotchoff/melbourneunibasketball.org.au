class MembersController < ApplicationController
  before_filter :assigns_gateway
 
  include ActiveMerchant::Billing
  include PaypalExpressHelper
 
  def index
    @left_sidebar = "sidebars/members"
    render_page(Page::CONTACT_JOIN_THE_CLUB)
  end
  
  def uniforms
    @left_sidebar = "sidebars/members"
    render_page(Page::CONTACT_UNIFORMS)
  end
  
  def documents_and_forms
    @left_sidebar = "sidebars/members"
    render_page(Page::CONTACT_DOCUMENTS_AND_FORMS)
  end
 
  def new
    @member = Member.new
    @member.payment_method = :paypal
  end
 
  def create
    @member = Member.new(params[:member])

    if @member.save
      if @member.payment_method == :paypal
        total_as_cents, setup_purchase_params = get_setup_purchase_params @member.amount_paid, request
        setup_response = @gateway.setup_purchase(total_as_cents, setup_purchase_params)
        @member.paypal_token = setup_response.token
        @member.save
        redirect_to @gateway.redirect_url_for(setup_response.token)
      else
        redirect_to mubc_account_details_member_path(@member)
      end
    else
      render action: "new"
    end
  end

  def mubc_account_details
    @left_sidebar = "sidebars/members"
    @member = Member.find(params[:id])
    if @member.payment_confirmed?
      redirect_to membership_path, flash: {error: "Whoops.. Seems like this member is already paid up. We wouldn't want to charge them twice!"} 
    end
  end

  def review_paypal_payment
    #TODO: instantiate @member
    
    if params[:token].nil?
      redirect_to membership_path, flash: {error: "Woops! Something went wrong and we can't find the paypal token"} 
      return
    end
 
    @member = Member.find_by_paypal_token(params[:token])
    
    gateway_response = @gateway.details_for(params[:token])
 
    unless gateway_response.success?
      redirect_to membership_path, flash: {error: "Sorry! Something went wrong with the Paypal purchase. Here's what Paypal said: #{gateway_response.message}"} 
      return
    end
    
    # @member.postal_address = gateway_response.address
    # @member.email = gateway_response.email
    # gateway_response.token
    # gateway_response.payer_id
 
    # @order_info = get_order_info gateway_response, @member
  end
  
  def confirm_paypal_purchase
    @member = Member.find(params[:id])
   if params[:token].nil? or params[:payer_id].nil?
      redirect_to home_url, :notice => "Sorry! Something went wrong with the Paypal purchase. Please try again later." 
      return
    end
 
    total_as_cents, purchase_params = get_purchase_params @cart, request, params
    purchase = @gateway.purchase total_as_cents, purchase_params
 
    if purchase.success?
      # you might want to destroy your cart here if you have a shopping cart 
      notice = "Thanks! Your purchase is now complete!"
    else
      notice = "Woops. Something went wrong while we were trying to complete the purchase with Paypal. Btw, here's what Paypal said: #{purchase.message}"
    end
 
    redirect_to home_url, :notice => notice    
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