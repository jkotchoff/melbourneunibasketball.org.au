class Member < ActiveRecord::Base
  attr_accessible :eligibility_clause, :eligibility_justification, :payment_method, \
                  :given_name, :family_name, :email, :postal_address,
                  :gender, :date_of_birth, :phone_number_mobile, :phone_number_other,
                  :new_member, :your_existing_mubc_singlet_numbers, :how_did_you_hear_about_the_club,
                  :amount_paid, :payment_confirmed, :photo, :photo_cache, :payment_acknowledgement

  validates_presence_of :eligibility_clause, :payment_method, :given_name, :family_name, :gender, \
                  :email, :date_of_birth, :phone_number_mobile, :phone_number_other, :amount_paid

  #TODO: validates_presence_of :eligibility_justification unless lambda{|m| ["life_member", "deferred_student", ""].index(m.eligibility_clause)}
  #      validates_presence_of :how_did_you_hear_about_the_club if :new_member?

  attr_accessor :terms_of_membership

  mount_uploader :photo, PhotoUploader
  process_in_background :photo

  scope :for_year, lambda{|year| where("created_at >= ? and created_at < ?", self.club_year_start(year), self.club_year_end(year))}
  scope :for_calendar_year, lambda{|year| where("created_at >= ? and created_at < ?", DateTime.parse("Jan 1 #{year}"), DateTime.parse("Dec 31 #{year}").end_of_day)}
  scope :current, lambda{ for_year(Date.today.year) }
  scope :not_expiring_soon, lambda{|year| for_year(year).paid.where("created_at >= ?", Date.new(year)) }
  scope :expiring_soon, lambda{|year| for_year(year).paid.where("created_at < ?", Date.new(year)) }
  scope :paid, where(payment_confirmed: true).order('family_name ASC')
  scope :unpaid, where(payment_confirmed: false).order('created_at DESC')

  # Note, this isn't being applied to winter season signups
  LATE_FEE = 10

  def self.funds_raised(year = Date.today.year)
    for_calendar_year(year).paid.sum(&:amount_paid)
  end

  def self.student_fee
    if Date.today >= self.winter_season_start
      40
    else
      70
    end
  end

  def self.non_student_fee
    if Date.today >= self.winter_season_start
      70
    else
      130
    end
  end

  def self.signup_start_date
    if Date.today >= self.winter_season_start
      self.winter_season_start.to_s(:month_day_year)
    else
      self.new_membership_club_year_start.to_s(:month_day_year)
    end
  end

  def self.new_membership_club_year_start
    jan_1_this_year = Date.new(Date.today.year, 1, 1)
  end

  def self.new_membership_club_year_end
    mar_31_next_year = Date.new(Date.today.year + 1, 3, 31)
  end

  # MUBC memberships are taken from jan 1 and should be valid until March 31 the following year
  def self.club_year_start(year = Date.today.year)
    march_31_this_year = Date.new(year, 3, 31)
    if Date.today <= march_31_this_year
      jan_1_last_year = Date.new(year - 1, 1, 1)
      return jan_1_last_year
    end
    jan_1_this_year = Date.new(year, 1, 1)
    return jan_1_this_year
  end

  def self.club_year_end(year = Date.today.year)
    mar_31_this_year = Date.new(year, 3, 31)
    mar_31_next_year = Date.new(year + 1, 3, 31)
    if Date.today < mar_31_this_year
      return mar_31_this_year
    else
      return mar_31_next_year
    end
  end

  # Late fees are applicable if membership is paid for after April 13th and before winter season start (August 1st)
  def self.late_fee_cutoff
    Date.new(Date.today.year, 4, 13)
  end

  def self.winter_season_start
    Date.new(Date.today.year, 8, 1)
  end

  def self.late_fee
    (Date.today > self.late_fee_cutoff and Date.today < self.winter_season_start) ? LATE_FEE : 0
  end

  def self.available_membership_years
    first_membership_year = Member.order(:created_at).pluck(:created_at).first.year
    this_year = Date.today.year
    first_membership_year..this_year
  end

  def age
    now = Time.now.utc.to_date
    now.year - date_of_birth.year - (date_of_birth.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def male?
    gender.to_s.downcase == "male"
  end

  def age_and_gender
    "#{age}yo #{gender.downcase}"
  end

  def name
    [given_name, family_name].reject(&:blank?).join(" ")
  end

  def reference(type = :full)
    # my HSBC account has an 18 character limit on beneficiary reference notes
    no = "%03d" % id
    code = "MUBC#{no}"
    if :code
      code
    else
      "#{code} #{given_name.chars.first} #{family_name}".first(18)
    end
  end

  def self.disclaimer
    %Q{
I agree to abide by the rules and regulations pertaining at all times to the use of University sports facilities, services and equipment.

I agree to abide by the Constitution of Melbourne University Basketball Club (MUBC) Inc. for the period #{self.new_membership_club_year_start.to_s(:month_day_year)} to #{self.new_membership_club_year_end.to_s(:month_day_year)}.

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
