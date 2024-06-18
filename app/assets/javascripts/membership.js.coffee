#representative_fee = 20

rebuild_price = ->
  big_v_fee = parseInt($('#annual_big_v_fee').val());
  big_v_development_fee = parseInt($('#annual_big_v_development_fee').val());
  big_v_tier_1_fee = parseInt($('#annual_big_v_tier_1_fee').val());
  big_v_tier_2_fee = parseInt($('#annual_big_v_tier_2_fee').val());
  big_v_tier_3_fee = parseInt($('#annual_big_v_tier_3_fee').val());
  student_fee     = parseInt($('#annual_student_fee').val())
  non_student_fee = parseInt($('#annual_non_student_fee').val())
  late_fee        = parseInt($('#late_fee').val())

  cost = 0
  fee_breakdown = []
  switch $("#member_eligibility_clause").val()
    when ""
      cost = -1
    when "committee_member"
      cost = 0
      $('#member_payment_method_bank_transfer').click()
    when "life_member"
      cost = 0
      $('#member_payment_method_bank_transfer').click()
    when "big_v_tier_4"
      cost = 0
      $('#member_payment_method_bank_transfer').click()
    when "enrolled_student_mu"
      fee_breakdown.push('$' + student_fee + ' for a Melbourne Uni student')
      cost += student_fee
    when "big_v_player"
      fee_breakdown.push('$' + big_v_fee + ' for a Big V Player')
      cost = big_v_fee
    when "big_v_development_player"
      fee_breakdown.push('$' + big_v_development_fee + ' for a Big V Development Player')
      cost = big_v_development_fee
    when "big_v_tier_1"
      fee_breakdown.push('$' + big_v_tier_1_fee + ' for a Big V Tier 1 Player')
      cost = big_v_tier_1_fee
    when "big_v_tier_2"
      fee_breakdown.push('$' + big_v_tier_2_fee + ' for a Big V Tier 2 Player')
      cost = big_v_tier_2_fee
    when "big_v_tier_3"
      fee_breakdown.push('$' + big_v_tier_3_fee + ' for a Big V Tier 3 Player')
      cost = big_v_tier_3_fee
    else
      fee_breakdown.push('$' + non_student_fee + ' for an eligible non-student')
      cost += non_student_fee
  if cost > 0 && late_fee > 0
    fee_breakdown.push('$' + late_fee + ' administrative surcharge for late payment (after April 1st)')
    cost += late_fee
  #if $('#member_representative_player').val() == 'true'
  #  fee_breakdown.push('$' + representative_fee + ' surcharge for playing in a representative grade')
  #  cost += representative_fee
  $('#membership_fee_dollars').text "$" + cost
  $('#member_amount_paid').val(cost)
  if cost != -1
    $('#membership_fee').show()
    if fee_breakdown.length > 1
      $('#membership_breakdown').text "ie. " + fee_breakdown.join(', ')
    else
      $('#membership_breakdown').text ""
  else
     $('#membership_fee').hide()

rebuild_eligibility_clause = ->
  if ["committee_member", "big_v_tier_4", "life_member"].indexOf($('#member_eligibility_clause').val()) >= 0 
    $('#member_eligibility_justification').hide()
    $('#eligibility_justification_label').hide()
    $('#payment_details').hide()
  else
    $('#eligibility_justification_label').show()
    $('#member_eligibility_justification').show()
    $('#payment_details').show()
    switch $('#member_eligibility_clause').val()
      when "enrolled_student_mu"
        $('#eligibility_justification_label').text("Student number, enrolled course and if applicable, college name")
      when "university_graduate"
        $('#eligibility_justification_label').text("Degree and Final Year")
      when "university_staff"
        $('#eligibility_justification_label').text("Department")
      when "committee_member"
        $('#eligibility_justification_label').text("Role")
      when "other_domestic"
        $('#eligibility_justification_label').text("Vocation")
      when "big_v_player", "big_v_development_player", "big_v_tier_1", "big_v_tier_2", "big_v_tier_3", "big_v_tier_4"
        $('#eligibility_justification_label').text("Team you are registering for")
    if !$('#member_eligibility_justification').val()
      $('#member_eligibility_justification').focus()

jQuery ($) ->
  if($("#admin_member_form").length > 0)
    return

  $("#photo_link").bind "click", ->
    $(".member_photo").each ->
      this.src = $(this).attr('url')
    false


  if(navigator.appName.indexOf("Internet Explorer")!=-1)
    $("#ie_warning").show()

  $("div.btn-group").each ->
    group = $(this)
    form = group.parents("form").eq(0)
    name = group.attr("data-toggle-name")
    hidden = $("input[name=\"" + name + "\"]", form)
    $(".btn", group).each ->
      button = $(this)
      button.bind "click", ->
        hidden.val $(this).find('input').val()
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

  rebuild_eligibility_clause()
  rebuild_price()

  $('#member_eligibility_clause').change ->
    rebuild_eligibility_clause()
    rebuild_price()

  $('#populate_fields').bind "click", ->
    $('#member_eligibility_clause').val('university_graduate')
    $('#member_eligibility_justification').show().val('RMIT')
    $('#member_given_name').val('John')
    $('#member_family_name').val('Smith')
    $('#member_email').val('someone@somewhere.com')
    $('#member_postal_address').val('1 Tin Alley lane, Melbourne University, Carlton 3004')
    $('#gender_male').click()
    $('#member_date_of_birth').val('01/01/1990')
    $('#member_phone_number_mobile').val('0400 123 456')
    $('#member_phone_number_other').val('9310 0123')
    rebuild_price()
    false

  # Disable forms onsubmit
  $('form').bind "submit", ->
    $('#submit_button').val("Loading..").attr('disabled','disabled')
    true
