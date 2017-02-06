class MemberDatabase
  require 'csv'

  def self.uniforms_csv
    filepath = "#{Rails.root}/tmp/melbourne_uni_basketball_members_#{Time.now.to_s(:file_timestamp)}.csv"
    months_reported = 24
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

      csv << ["Mens numbers that haven't been used by a member in the last #{months_reported} months", "", ""]
      csv << [
        '"' + (1..55).select{|i| !current_mens_numbers.keys.include?(i) }.join(", ") + '"',
        '',
        ''
      ]

      csv << ["", "", ""]

      csv << ["Womens numbers that haven't been used by a member in the last #{months_reported} months", "", ""]
      csv << [
        '"' + (1..55).select{|i| !current_womens_numbers.keys.include?(i) }.join(", ") + '"',
        '',
        ''
      ]

      csv << ["", "", ""]

      csv << ["Mens Number", "# Currently Issued", "Issued to"]
      current_mens_numbers.each_pair do |number, names|
        csv << [ number, names.uniq.length, names.uniq.join(", ") ]
      end

      csv << ["", "", ""]

      csv << ["Womens Number", "# Currently Issued", "Issued to"]
      current_womens_numbers.each_pair do |number, names|
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