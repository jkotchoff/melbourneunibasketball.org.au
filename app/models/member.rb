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

  attr_accessor :terms_of_membership

  mount_uploader :photo, PhotoUploader
  process_in_background :photo

  scope :current, lambda{ where("created_at >= ? and created_at < ?", self.club_year_start, (Date.today + 1.day))}
  scope :paid, where(payment_confirmed: true).order('family_name ASC')
  scope :unpaid, where(payment_confirmed: false).order('created_at ASC')
  
  #TODO: make this configurable
  STUDENT_FEE = 70
  NON_STUDENT_FEE = 130
  LATE_FEE = 10

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

  # Late fees are applicable if membership is paid for after April 1st
  def self.late_fee
    (Date.today > Date.new(Date.today.year, 4, 1)) ? LATE_FEE : 0 
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

  def self.disclaimer
    %Q{
I agree to abide by the rules and regulations pertaining at all times to the use of University sports facilities, services and equipment.

I agree to abide by the Constitution of Melbourne University Basketball Club (MUBC) Inc. for the period #{self.club_year_start.to_s(:month_day_year)} to #{self.club_year_end.to_s(:month_day_year)}.

I understand that in the circumstance where a MUBC Inc team at a domestic, representative or tournament level receives a walkover fine for non-attendance at a game for any reason other than incorrect advice from the relevant association, the sole responsibility for the payment of that fine is held by that MUBC Inc. team. I am liable for any irresponsible behaviour leading to damage or loss of funds to the club by individuals or teams.

I understand that membership fees are non-refundable.

Melbourne University Sports (MUS) are committed to observing the requirements of the Information Privacy Act. 

We collect your information for the purpose of providing you access to our sporting facilities and services, and it is also retained for the development of a sports alumni at the University of Melbourne. 

By completing this form you consent to MUS using your information for these purposes. 

If, in the future you decline to be involved in the MUS sports alumni, you can so advise MUS. 

You can also contact MUS for a copy of the MUS Privacy Policy, or obtain a copy from www.sports.unimelb.edu.au    
    }
  end
end
