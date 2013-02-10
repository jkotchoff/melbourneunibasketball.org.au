class Member < ActiveRecord::Base
  attr_accessible :eligibility_clause, :eligibility_justification, :payment_method, \
                  :representative_player, :given_name, :family_name, :email, :postal_address,
                  :gender, :date_of_birth, :phone_number_mobile, :phone_number_other,
                  :new_member, :your_existing_mubc_singlet_numbers, :how_did_you_hear_about_the_club,
                  :amount_paid
                  
  validates_presence_of :eligibility_clause, :payment_method, :given_name, :family_name, :gender, \
                  :date_of_birth, :phone_number_mobile, :phone_number_other, :amount_paid

  #TODO: validates_presence_of :eligibility_justification unless lambda{|m| ["life_member", "deferred_student", ""].index(m.eligibility_clause)}
  #      validates_presence_of :how_did_you_hear_about_the_club if :new_member?

  def reference
    "%03d" % id
  end

end
