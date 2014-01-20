class MemberDatabase
  require 'csv'
  
  def self.export_csv
    filepath = "#{Rails.root}/tmp/melbourne_uni_basketball_members_#{Time.now.to_s(:file_timestamp)}.csv"
    CSV.open(filepath, "wb") do |csv|
      csv << ['Given Name', 'Family Name', "Postal Address", "Mobile Number", "Emergency Phone", "Email", "Date of Birth", "Gender", "Signup Date", "Eligibility Clause", "Eligibility Justification", "Payment Acknowledgement"]
      Member.current.paid.each do |m|
        csv << [m.given_name, m.family_name, m.postal_address, m.phone_number_mobile, m.phone_number_other, m.email, m.date_of_birth.to_s(:month_day_year), m.gender, m.created_at.to_s(:month_day_year), m.eligibility_clause, m.eligibility_justification, m.payment_acknowledgement]
      end
      puts "written #{filepath}"
      csv.path
    end
    filepath
  end
end