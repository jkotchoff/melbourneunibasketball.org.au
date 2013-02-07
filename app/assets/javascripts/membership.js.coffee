student_fee = 70
non_student_fee = 110
representative_fee = 20

rebuild_price = ->
  cost = 0
  fee_breakdown = []
  switch $("#eligibility_clause").val()
    when ""
      cost = -1
    when "enrolled_student_mu"
      fee_breakdown.push('$' + student_fee + ' for a Melbourne Uni student')
      cost += student_fee
    else
      fee_breakdown.push('$' + non_student_fee + ' for an eligible non-student')
      cost += non_student_fee
  if $('#member_representative_player').val() == '1'
    fee_breakdown.push('$' + representative_fee + ' surcharge for playing in a representative grade')
    cost += representative_fee
  $('#membership_fee_dollars').text "$" + cost
  if cost != -1 and fee_breakdown.length > 1
     $('#membership_breakdown').text "ie. " + fee_breakdown.join(', ')
  else
     $('#membership_breakdown').text ""

jQuery ($) ->
  $("div.btn-group").each ->
    group = $(this)
    form = group.parents("form").eq(0)
    name = group.attr("data-toggle-name")
    hidden = $("input[name=\"" + name + "\"]", form)
    $("button", group).each ->
      button = $(this)
      button.bind "click", ->
        hidden.val $(this).val()
        if($(this).attr('id') == 'existing_member')
          $("#introductory_source").hide()
          $("#singlet_numbers").show()
        else if($(this).attr('id') == 'is_new_member')
          $("#singlet_numbers").hide()
          $("#introductory_source").show()
        else if($(this).attr('id') == 'representative_button')
          rebuild_price()
        else if($(this).attr('id') == 'non_representative_button')
          rebuild_price()
      button.addClass "active"  if button.val() is hidden.val()

  $('#member_payment_method_paypal').bind 'click', ->
    $('#bank_transfer_instructions').hide()
    $('#paypal_instructions').show()

  $('#member_payment_method_bank_transfer').bind 'click', ->
    $('#paypal_instructions').hide()
    $('#bank_transfer_instructions').show()

  $('#eligibility_clause').change ->
    rebuild_price()
    $('#membership_steps, #membership_form').show()
    $('#member_eligibility_justification').show()
    $('#eligibility_justification').val $(this).val() 
    $('#eligibility_justification_label').show() 
    if ["life_member", "deferred_student", ""].indexOf($(this).val()) >= 0
      $('#member_eligibility_justification').hide()
      $('#eligibility_justification_label').hide()
    else
      switch $(this).val()
        when "enrolled_student_mu"
          $('#eligibility_justification_label').text("Student number")
        when "enrolled_student_elsewhere"
          $('#eligibility_justification_label').text("Institution name")
        when "university_graduate"
          $('#eligibility_justification_label').text('University, Degree and Final Year')
        when "university_staff"
          $('#eligibility_justification_label').text('Department')
        when "working_on_site"
          $('#eligibility_justification_label').text('Employed by')
        when "college_affiliation"
          $('#eligibility_justification_label').text('College')
        when "immediate_family"
          $('#eligibility_justification_label').text('Eligible Family Member\'s name')
        when "directors_discretion"
          $('#eligibility_justification_label').text('Director\'s name and justification')
      #TODO: $('#eligibility_justification_label').focus()
          
