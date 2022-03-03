class TransactionsController < ApplicationController
  def create
    token = Token.find(params[:token_id])
    transaction  = Transaction.create!(token: token, token_sku: token.sku, amount: token.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: token.sku,
        amount: token.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    transaction.update(checkout_session_id: session.id)
    redirect_to new_transaction_payment_path(transaction)
  end

  def show
    @transaction = current_user.transactions.find(params[:id])
  end
end
