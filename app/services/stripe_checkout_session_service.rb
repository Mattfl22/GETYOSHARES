class StripeCheckoutSessionService
  def call(event)
    transaction = Transaction.find_by(checkout_session_id: event.data.object.id)
    transaction.update(state: 'paid')
  end
end
