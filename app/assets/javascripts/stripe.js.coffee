StripeI18n =
  es:
    errors:
      incorrect_number: "El número de tarjeta es incorrecto."
      invalid_number: "Existe un error en los datos de la tarjeta de crédito. Por favor, revísalos antes de continuar."
      invalid_expiry_month: "El mes de caducidad de la tarjeta no es válido."
      invalid_expiry_year: "El año de caducidad de la tarjeta no es válido."
      invalid_cvc: "El código de seguridad de la tarjeta no es válido."
      expired_card: "La tarjeta ha caducado."
      incorrect_cvc: "El código de seguridad de la tarjeta es incorrecto."
      incorrect_zip: "Falló la validación del código postal de la tarjeta."
      card_declined: "La tarjeta fué rechazada."
      missing: "El cliente al que se está cobrando no tiene tarjeta"
      processing_error: "Ocurrió un error procesando la tarjeta."
      rate_limit:  "Ocurrió un error debido a consultar la API demasiado rápido. Por favor, avísanos si recibes este error continuamente."




jQuery ->
  Stripe.setPublishableKey($('#stripe-key').data('content'))
  reservation.setupForm()

reservation =
  setupForm: ->
    $('#new_reservation').submit ->
      $('.stripe-error').addClass("hidden")
      $(this).find("[name='commit']").prop('disabled', true)
      reservation.processCard()
      false

  processCard: ->
    card =
      name: $('#card_holder').val()
      number: $('#card_number').val()
      cvc: $('#card_cvc').val()
      expMonth: $('#exp_month').val()
      expYear: $('#exp_year').val()      
    Stripe.createToken(card, reservation.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    if status == 200
      $('#stripe_card_token').val(response.id)
      $('#new_reservation')[0].submit()
    else
      closeModal('payment-modal');
      $('.stripe-error').removeClass("hidden").text(StripeI18n.es.errors[response.error.code])
      $('#new_reservation').find("[name='commit']").prop('disabled', false)