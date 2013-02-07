module PaypalExpressHelper
  def get_setup_purchase_params(total, request)
    return to_cents(total), {
      :ip => request.remote_ip,
      :return_url => url_for(:action => 'review_paypal_payment', :only_path => false),
      :cancel_return_url => membership_url,
      :subtotal => to_cents(total),
      :shipping => 0,
      :handling => 0,
      :tax =>      0,
      :allow_note =>  true,
      :items => [{ name: "MUBC Annual Membership - 2012", number: 1, quantity: 1, amount: to_cents(total) }],
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
    (money*100).round
  end
  
  def eligibility_options
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
    }, params[:eligibility])
  end
end