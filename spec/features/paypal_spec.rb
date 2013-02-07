require 'spec_helper'

feature "Paypal" do
  include ActiveMerchant::Billing
  
  let(:users_address) { '123 street, somewhere' }
  let(:users_email) { 'someone@somewhere.com' }
  
  before do
    # Stub system to bypass paypal and return us to our review page
    paypal_stub = Object.new
    PaypalExpressGateway.stub!(:new).and_return(paypal_stub)
    response_stub = Object.new
    response_stub.stub!(:token)
    paypal_stub.stub!(:setup_purchase).and_return(response_stub)
    paypal_stub.stub!(:redirect_url_for).and_return(membership_review_path(token: '123'))
    paypal_stub.stub!(:details_for).and_return(OpenStruct.new({address: users_address, email: users_email}))
  end
  
  #TODO: context for student discounts and late payment surcharges
  
  scenario "signup for annual members subs fees" do
    lambda {
      visit membership_fees_path
      click_button 'Male'
      select 'Life member', from: 'eligibility'
      click_button 'Take me to Paypal'

      find_field('Postal Address').value.should == users_address
      find_field('Email').value.should == users_email
      click_button 'Confirm Payment'

    }.should change(Member, :count).by(1)
  end
end
