class Member < ActiveRecord::Base
  attr_accessible :eligibility_clause, :eligibility_justification, :payment_method, \
                  :given_name, :family_name, :email, :postal_address,
                  :gender, :date_of_birth, :phone_number_mobile, :phone_number_other,
                  :new_member, :your_existing_mubc_singlet_numbers, :how_did_you_hear_about_the_club,
                  :amount_paid, :payment_confirmed, :photo, :photo_cache, :payment_acknowledgement
                  
  validates_presence_of :eligibility_clause, :payment_method, :given_name, :family_name, :gender, \
                  :date_of_birth, :phone_number_mobile, :phone_number_other, :amount_paid

  #TODO: validates_presence_of :eligibility_justification unless lambda{|m| ["life_member", "deferred_student", ""].index(m.eligibility_clause)}
  #      validates_presence_of :how_did_you_hear_about_the_club if :new_member?

  mount_uploader :photo, PhotoUploader

  scope :current, lambda{ where("created_at >= ? and created_at < ?", self.club_year_start, (Date.today + 1.day))}
  scope :paid, where(payment_confirmed: true).order('family_name ASC')
  scope :unpaid, where(payment_confirmed: false).order('created_at ASC')

  # MUBC memberships are taken from jan 1 and should be valid until March 31 the following year  
  def self.club_year_start
    march_31_this_year = Date.new(Date.today.year, 3, 31)
    if Date.today <= march_31_this_year
      jan_1_last_year = Date.new(Date.today.year - 1, 1, 1)
      return jan_1_last_year
    end 
    jan_1_this_year = Date.new(Date.today.year, 1, 1)
    return jan_1_this_year
  end

  def self.club_year_end
    mar_31_this_year = Date.new(Date.today.year, 3, 31)
    mar_31_next_year = Date.new(Date.today.year + 1, 1, 31)
    if Date.today < mar_31_this_year
      return mar_31_this_year
    else
      return mar_31_next_year
    end
  end

  def age_and_gender
    age = Date.today.year - date_of_birth.year
    "#{age}yo #{gender.downcase}"
  end

  def name
    [given_name, family_name].reject(&:blank?).join(" ")
  end

  def reference
    # my HSBC account has an 18 character limit on beneficiary reference notes
    no = "%03d" % id 
    "MUBC#{no} #{given_name.chars.first} #{family_name}".first(18) 
  end

end
