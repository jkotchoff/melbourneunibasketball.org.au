module PaypalExpressHelper
  def to_cents(money)
    (money.to_f*100).round
  end

  def membership_details
    %w{ given_name family_name eligibility_clause eligibility_justification gender date_of_birth phone_number_mobile phone_number_other new_member your_existing_mubc_singlet_numbers how_did_you_hear_about_the_club }
  end

  def member_field(field_name)
    attr = @member.send(field_name)
    if field_name == "date_of_birth"
      return attr.to_s(:month_day_year)
    end
    attr.to_s
  end

  def eligibility_options
    selected = (@member)? @member.eligibility_clause : params[:member][:eligibility_clause] rescue nil
    options_for_select({
      'None' => '',
      'Domestic: Enrolled Melbourne Uni Student' => 'enrolled_student_mu',
      'Domestic: Melbourne Uni Alumni' => 'university_graduate',
      'Domestic: Melbourne Uni Staff' => 'university_staff',
      'Domestic: Other' => 'other_domestic',
      'Big V: Rostered Player' => 'big_v_player',
      'Big V: Development Player' => 'big_v_development_player',
      'MUBC Life Member' => 'life_member',
      'MUBC Committee Member' => 'committee_member',
      'Miscellaneous: Tier 1 (Big V)' => 'big_v_tier_1',
      'Miscellaneous: Tier 2 (Big V)' => 'big_v_tier_2',
      'Miscellaneous: Tier 3 (Big V)' => 'big_v_tier_3',
      'Miscellaneous: Tier 4 (Big V)' => 'big_v_tier_4',
    }, selected)
  end
end
