class MembersController < ApplicationController
  before_filter :load_sidebar
  before_filter :assigns_gateway, only: [:create, :review_paypal_payment, :confirm_paypal_purchase]
 
  include ActiveMerchant::Billing
  include PaypalExpressHelper
 
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
    @member = Member.new(params[:member])

    if @member.save
      if @member.payment_method == 'paypal'
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
    @member = Member.find(params[:id])
    if @member.payment_confirmed?
      redirect_to membership_path, flash: {error: "Whoops.. Seems like this member is already paid up. We wouldn't want to charge them twice!"} 
    end
  end

  def review_paypal_payment
    if params[:token].nil?
      redirect_to membership_path, flash: {error: "Woops! Something went wrong and we can't find the paypal token"} 
      return
    end
 
    @member = Member.find_by_paypal_token(params[:token])
    gateway_response = @gateway.details_for(params[:token])
    @member.postal_address = gateway_response.address.values_at("company", "address1", "address2", "city", "state", "country", "zip").reject(&:blank?).join(", ")
    @member.email = gateway_response.email
    @member.paypal_token = gateway_response.token
    @member.paypal_payer_id = gateway_response.payer_id
    @member.save

    unless gateway_response.success?
      redirect_to membership_path, flash: {error: "Sorry! Something went wrong with the Paypal purchase. Here's what Paypal said: #{gateway_response.message}"} 
      return
    end
  end
  
  def confirm_paypal_purchase
    @member = Member.find(params[:id])
    @member.update_attributes(
      email: params[:member][:email],
      postal_address: params[:member][:postal_address]
    )
 
    total_as_cents, purchase_params = get_purchase_params @member.amount_paid, @member.paypal_token, @member.paypal_payer_id 
    purchase = @gateway.purchase total_as_cents, purchase_params
 
    if purchase.success?
      @member.update_attributes(payment_confirmed: true, payment_acknowledgement: "Payment submitted via Paypal")
      redirect_to thankyou_member_path, flash: {notice: "Payment processed successfully"}
    else
      notice = "Woops. Something went wrong while we were trying to complete the purchase with Paypal. Btw, here's what Paypal said: #{purchase.message}"
      redirect_to membership_path, flash: {:error => notice}    
    end
 
  end
  
  def thankyou
    @member = Member.find(params[:id])
    unless @member.payment_method == 'paypal'
      notice = "Woops. Somehow you got sent to the paypal thankyou page when really you were paying with account/bsb"
      redirect_to membership_path, flash: {:error => notice}
    end    
  end
   
  private
    def load_sidebar
      @left_sidebar = "sidebars/members"
    end

    def assigns_gateway
      @gateway ||= PaypalExpressGateway.new(
        :login => ENV['PAYPAL_LOGIN'],
        :password => ENV['PAYPAL_PASSWORD'],
        :signature => ENV['PAYPAL_SIGNATURE']
      )
    end
end