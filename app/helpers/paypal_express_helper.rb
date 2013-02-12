module PaypalExpressHelper
  def get_setup_purchase_params(total, request)
    return to_cents(total), {
      :ip => request.remote_ip,
      :return_url => url_for(:action => 'review_paypal_payment', :only_path => false),
      :currency => "AUD",
      :cancel_return_url => membership_url,
      :subtotal => to_cents(total),
      :shipping => 0,
      :handling => 0,
      :tax =>      0,
      :allow_note =>  false,
      :items => [{ name: "MUBC Annual Membership - #{Date.today.year}", number: 1, quantity: 1, amount: to_cents(total) }],
    }
  end

  def get_purchase_params(total, token, payer_id)
    return to_cents(total), {
      :ip => request.remote_ip,
      :token => token,
      :payer_id => payer_id,
      :currency => "AUD",
      :subtotal => to_cents(total),
      :shipping => 0,
      :handling => 0,
      :tax =>      0,
      :items => [{ name: "MUBC Annual Membership - #{Date.today.year}", number: 1, quantity: 1, amount: to_cents(total) }],
    }
  end  
  
=begin 
  def get_order_info(gateway_response, cart)
    subtotal, shipping, total = get_totals(cart)
    {
      shipping_address: gateway_response.address,
      email: gateway_response.email,
      gateway_details: {
        :token => gateway_response.token,
        :payer_id => gateway_response.payer_id,
      },
      subtotal: subtotal,
      shipping: shipping,
      total: total,
    }
  end
=end 
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
      'Enrolled Melbourne Uni Student' => 'enrolled_student_mu', 
      'Enrolled Student at other tertiary institution' => 'enrolled_student_elsewhere',
      'University Graduate' => 'university_graduate', 
      "University Staff" => "university_staff",
      "Working on a Melbourne Uni site" => "working_on_site",
      "Resident, Member or Staff at a Melbourne Uni affiliated college or hall of residence" => "college_affiliation",
      "Deferred Melbourne Uni Student" => "deferred_student",
      "Immediate family of current student or eligible non student" => "immediate_family",
      "MUBC Life member" => 'life_member',
      "Eligible under Director's discretion" => 'directors_discretion',
    }, selected)
  end
end