jQuery ($) ->
  $('.payment_acknowledgement').bind "click", ->
    confirmation = prompt("How did they make payment?\neg.\n'$70 Bank Transfer to MUBC account'\n or\n'Paid $130 cash to Cozzy at training on Feb 9th'")
    if confirmation != null
      window.location = this.href + "?payment_acknowledgement=" + confirmation 
    false
