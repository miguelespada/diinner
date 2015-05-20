jQuery ->
  Stripe.setPublishableKey($('#stripe-key').data('content'))
  reservation.setupForm()

reservation =
  setupForm: ->
    $('#new_reservation').submit ->
      $(this).find("[name='commit']").prop('disabled', true)
      reservation.processCard()
      false

  processCard: ->
    card =
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
      $('.stripe-error').text(response.error.message)
      $('#new_reservation').find("[name='commit']").prop('disabled', false)