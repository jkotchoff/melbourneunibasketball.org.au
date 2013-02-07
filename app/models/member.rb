class Member < ActiveRecord::Base
  attr_accessible :eligibility_clause, :eligibility_justification, :payment_method, \
                  :representative_player, :given_name, :family_name, :email, :postal_address,
                  :gender, :date_of_birth, :phone_number_mobile, :phone_number_other,
                  :new_member, :your_existing_mubc_singlet_numbers, :how_did_you_hear_about_the_club
                  
  validates_presence_of :eligibility_clause, :payment_method, :given_name, :family_name, :gender, \
                  :date_of_birth, :phone_number_mobile, :phone_number_other

  validates_presence_of :how_did_you_hear_about_the_club if :new_member?

=begin  
  def initialize(*params)
    self.are_you_a_new_member = 1
    self.payment_method = :paypal
    self.representative_player = 0
    super(params)
  end
=end  
end
