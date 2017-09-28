module MembersHelper
  def credit_card_months
    options_for_select [
      ["Jan (01)", "1"],
      ["Feb (02)", "2"],
      ["Mar (03)", "3"],
      ["Apr (04)", "4"],
      ["May (05)", "5"],
      ["June (06)", "6"],
      ["July (07)", "7"],
      ["Aug (08)", "8"],
      ["Sep (09)", "9"],
      ["Oct (10)", "10"],
      ["Nov (11)", "11"],
      ["Dec (12)", "12"]
    ]
  end

  def credit_card_years
    options_for_select (Date.today.year..(Date.today.year + 10)).map{|y| [y, y]}
  end
end
