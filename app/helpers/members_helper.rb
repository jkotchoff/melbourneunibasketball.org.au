module MembersHelper
  def credit_card_months
    options_for_select [
      ["Jan (01)", "01"],
      ["Feb (02)", "02"],
      ["Mar (03)", "03"],
      ["Apr (04)", "04"],
      ["May (05)", "05"],
      ["June (06)", "06"],
      ["July (07)", "07"],
      ["Aug (08)", "08"],
      ["Sep (09)", "09"],
      ["Oct (10)", "10"],
      ["Nov (11)", "11"],
      ["Dec (12)", "12"]
    ]
  end

  def credit_card_years
    options_for_select (Date.today.year..(Date.today.year + 10)).map{|y| [y, y]}
  end
end
