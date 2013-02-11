require 'spec_helper'

feature "Paypal" do
  include ActiveMerchant::Billing
  
  let(:users_email) { 'someone@somewhere.com' }
  
  before do
    # Stub system to bypass paypal and return us to our review page
    paypal_stub = Object.new
    paypal_stub.stub!(:purchase).and_return(OpenStruct.new("success?" => true))
    PaypalExpressGateway.stub!(:new).and_return(paypal_stub)
    response_stub = Object.new
    response_stub.stub!(:token).and_return('123')
    paypal_stub.stub!(:setup_purchase).and_return(response_stub)
    paypal_stub.stub!(:redirect_url_for).and_return(review_paypal_payment_members_path(token: '123'))
    paypal_stub.stub!(:details_for).and_return(OpenStruct.new({"address" => {"address1" => '123 street', "country" => 'somewhere'}, "email" => users_email, "success?" => true}))
  end
  
  #TODO: context for student discounts and late payment surcharges
  
  scenario "signup for annual members subs fees" do
    lambda {
      visit join_the_club_path
      select 'MUBC Life member', from: 'member_eligibility_clause'
      fill_in "Given name", :with => "Phil"
      fill_in "Family name", :with => "Ashworth"
      find(:xpath, "//input[@id='member_gender']").set "Male"
      find(:xpath, "//input[@id='member_amount_paid']").set "110"
      fill_in "Date of birth", :with => "01/01/1940"
      fill_in "member[phone_number_mobile]", :with => "1800 PISTOLS"
      fill_in "member[phone_number_other]", :with => "1800 ERICA"
      click_button 'gender_male'
      click_button 'Submit'

      find_field('Postal address').value.should == '123 street, somewhere'
      find_field('Email').value.should == users_email
      first(:button, 'Confirm Payment').click
    }.should change(Member, :count).by(1)
    
    user_matches = Member.where(email: users_email)
    user_matches.count.should == 1
    user_matches.first.given_name.should == 'Phil'
    user_matches.first.email.should == users_email
  end
end
