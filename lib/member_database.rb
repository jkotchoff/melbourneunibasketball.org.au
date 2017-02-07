class MemberDatabase
  require 'csv'

  def self.uniforms_csv
    filepath = "#{Rails.root}/tmp/melbourne_uni_basketball_members_#{Time.now.to_s(:file_timestamp)}.csv"
    months_reported = 12

    # https://au.answers.yahoo.com/question/index?qid=20090521061008AAQ5lyM
    eligible_numbers = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 20, 21, 22, 23, 24, 25, 30, 31, 32, 33, 34, 35, 40, 41, 42, 43, 44, 45, 50, 51, 52, 52, 53, 54, 55]
    CSV.open(filepath, "wb") do |csv|
      current_mens_numbers = {}
      current_womens_numbers = {}

      query = Member.where("your_existing_mubc_singlet_numbers is not null and your_existing_mubc_singlet_numbers <> ''")
      query.group_by(&:name).each do |name, memberships|
        numbers_listed = memberships.collect(&:your_existing_mubc_singlet_numbers).join(" & ")
        numbers = numbers_listed.split.select{|v| Integer(v) rescue nil }.collect(&:to_i)

        next unless numbers.present?
        next if memberships.collect(&:created_at).sort.last < months_reported.months.ago

        numbers.each do |number|
          if memberships.first.gender.downcase == 'male'
            current_mens_numbers[number] ||= []
            current_mens_numbers[number] << name
          else
            current_womens_numbers[number] ||= []
            current_womens_numbers[number] << name
          end
        end
      end

      csv << ["Mens numbers that haven't been used by a member in the last #{months_reported} months - doesn't include new numbers issued last year or uniforms that are currently in stock in the cabinet", "", ""]
      csv << [
        '"' + eligible_numbers.select{|i| !current_mens_numbers.keys.include?(i) }.join(", ") + '"',
        '',
        ''
      ]

      csv << ["", "", ""]

      csv << ["Womens numbers that haven't been used by a member in the last #{months_reported} months - doesn't include new numbers issued last year or uniforms that are currently in stock in the cabinet", "", ""]
      csv << [
        '"' + eligible_numbers.select{|i| !current_womens_numbers.keys.include?(i) }.join(", ") + '"',
        '',
        ''
      ]

      csv << ["", "", ""]

      csv << ["Mens Number", "# Currently Issued", "Issued to"]
      current_mens_numbers.keys.sort.each do |number|
        names = current_mens_numbers[number]
        csv << [ number, names.uniq.length, names.uniq.join(", ") ]
      end

      csv << ["", "", ""]

      csv << ["Womens Number", "# Currently Issued", "Issued to"]
      current_womens_numbers.keys.sort.each do |number|
        names = current_womens_numbers[number]
        csv << [ number, names.uniq.length, names.uniq.join(", ") ]
      end

      puts "written #{filepath}"
      csv.path
    end
    filepath
  end

  def self.export_csv
    filepath = "#{Rails.root}/tmp/melbourne_uni_basketball_members_#{Time.now.to_s(:file_timestamp)}.csv"
    CSV.open(filepath, "wb") do |csv|
      csv << [
        'Given Name',
        'Family Name',
        "Postal Address",
        "Mobile Number",
        "Emergency Phone",
        "Email",
        "Date of Birth",
        "Gender",
        "Signup Date",
        "Eligibility Clause",
        "Eligibility Justification",
        "Payment",
        "Payment Acknowledgement"
      ]
      Member.current.paid.each do |m|
        csv << [
          m.given_name,
          m.family_name,
          m.postal_address,
          m.phone_number_mobile,
          m.phone_number_other,
          m.email,
          m.date_of_birth.to_s(:month_day_year),
          m.gender,
          m.created_at.to_s(:month_day_year),
          m.eligibility_clause,
          m.eligibility_justification,
          m.amount_paid,
          m.payment_acknowledgement
        ]
      end
      puts "written #{filepath}"
      csv.path
    end
    filepath
  end
end