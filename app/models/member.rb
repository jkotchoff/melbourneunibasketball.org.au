class Member < ActiveRecord::Base
  validates_presence_of :eligibility_clause, :given_name, :family_name, :gender, \
                  :email, :date_of_birth, :phone_number_mobile, :phone_number_other, :amount_paid

  #TODO: validates_presence_of :eligibility_justification unless lambda{|m| ["life_member", "deferred_student", ""].index(m.eligibility_clause)}
  #      validates_presence_of :how_did_you_hear_about_the_club if :new_member?

  attr_accessor :terms_of_membership
  attr_accessor :card_number, :card_expiry_month, :card_expiry_year, :card_cvv
  validate :credit_card_details

  mount_uploader :photo, PhotoUploader
  process_in_background :photo

  before_validation :activate_club_volunteers

  scope :for_year, lambda{|year| where("created_at >= ? and created_at < ?", self.club_year_start(year), self.club_year_end(year))}
  scope :for_calendar_year, lambda{|year| where("created_at >= ? and created_at < ?", DateTime.parse("Jan 1 #{year}"), DateTime.parse("Dec 31 #{year}").end_of_day)}
  scope :current, lambda{ for_year(Date.today.year) }
  scope :not_expiring_soon, lambda{|year| for_year(year).paid.where("created_at >= ?", Date.new(year)) }
  scope :expiring_soon, lambda{|year| for_year(year).paid.where("created_at < ?", Date.new(year)) }
  scope :paid, -> { where(payment_confirmed: true).order('family_name ASC') }
  scope :unpaid, -> { where(payment_confirmed: false).order('created_at DESC') }

  # Note, this isn't being applied to winter season signups
  LATE_FEE = 10

  def credit_card_details
    if new_record? && !Rails.env.test? && amount_paid.to_i > 0
      errors.add(:card_number) if card_number.blank?
      errors.add(:card_expiry_month) if card_expiry_month.blank?
      errors.add(:card_expiry_year) if card_expiry_year.blank?
      errors.add(:card_cvv) if card_cvv.blank?
    end
  end

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

I consent that I may be photographed and that photograph's of me may be used in the MUBC newsletter or MUBC social media accounts.

The Information you have provided in this Club Membership Form will be used by MU Sport to facilitate your access to, and useof, MU Sport facilities and services through the relevant MU Sport Club with which you are a member. MU Sport may also use this information for its internal planning purposes and the development of a ‘sports alumni’ at the University. By completing this form, you provide your consent to the University using your information for these purposes. The University must comply with the Privacy and Data Protection Act 2014 (VIC) when collecting, using, disclosing and managing personal information. You may access the University’s policy at http://www.unimelb.edu.au/governance/compliance/privacy and privacy queries may be directed to privacy-officer@unimelb.edu.au

I acknowledge that MU Sport seeks to provide an environment that encourages the positive values of respect, fairness, responsibility and safety.I have read and understood, and agree to comply with, all applicable University or MU Sport policies and procedures which are set out at http://www.sport.unimelb.edu.au/clubresources and will obey the reasonable instructions of MU Sport and Club activity facilitators or instructors as relevant to my Club. I understand that if I:
a) Engage in activities that bring MU Sport and/or the University into disrepute or that are illegal;
b) Intentionally misuse or cause damage to MU Sport assets or property;
c) Engage in a serious misuse of Club funds or misappropriation of Club funds; or
d) Engage in a serious breach of a University or MU Sport policy

That MU Sport may act against me to suspend or terminate my membership, and in the event that I am a University staff member or student, that MU Sport reserves the right to take further disciplinary action under the relevant University statutes, regulations, policies and procedures.
    }
  end

private
  def activate_club_volunteers
    if new_record? && %w{ life_member committee_member }.include?(eligibility_clause)
      self.payment_confirmed = true
    end
  end

end
