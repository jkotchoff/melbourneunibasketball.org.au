require 'spec_helper'

feature "Stripe Membership Payment" do
  #include ActiveMerchant::Billing

  # https://jetruby.com/expertise/integrate-stripe-gem-rails-app/

  let(:users_email) { 'someone@somewhere.com' }

  #TODO: context for student discounts and late payment surcharges

  before do
    StripeMock.start
#    user.update(customer_id: Stripe::Customer.create(email: user.email).id)
#    sign_in user
  end

  after { StripeMock.stop }

  scenario "signup for annual members subs fees" do
    lambda {
      visit join_the_club_path
      select 'University Graduate', from: 'member_eligibility_clause'

      fill_in "Name on credit card", with: "Flash Ash"
      fill_in "Credit Card Number", with: "4242424242424242"
      find(:xpath, "//select[@id='member_card_expiry_month']").set '10'
      find(:xpath, "//select[@id='member_card_expiry_year']").set (Date.today.year + 1).to_s
      fill_in "Card CVV", with: "123"

      fill_in "Given name", :with => "Phil"
      fill_in "Family name", :with => "Ashworth"
      find(:xpath, "//input[@id='member_email']").set users_email
      find(:xpath, "//input[@id='member_gender']").set "Male"
      find(:xpath, "//input[@id='member_amount_paid']", visible: false).set "110"
      fill_in "Date of birth", :with => "01/01/1940"
      fill_in "member[phone_number_mobile]", :with => "1800 PISTOLS"
      fill_in "member[phone_number_other]", :with => "1800 ERICA"
      click_button 'gender_male'
      click_button 'Submit'
      find_field('Postal address').value.should == '123 street, somewhere'
      first(:button, 'Confirm Payment').click
    }.should change(Member, :count).by(1)

    user_matches = Member.where(email: users_email)
    user_matches.count.should == 1
    member = user_matches.first
    member.given_name.should == 'Phil'
    member.email.should == users_email
    member.stripe_customer_id.should_not be_nil

  end
end
