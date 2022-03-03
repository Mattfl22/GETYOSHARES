class TransactionsController < ApplicationController
  def create
    token = Token.find(params[:token_id])
    @transaction  = Transaction.create!(token: token, amount: token.price, state: 'pending', user: current_user)
    authorize @transaction

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: "token.sku",
        amount: token.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: project_transaction_url(@transaction.token.project, @transaction),
      cancel_url: project_transaction_url(@transaction.token.project, @transaction)
    )

    @transaction.update(checkout_session_id: session.id)
    redirect_to new_project_transaction_payment_path(@transaction.token.project, @transaction)
  end

  def show
    @transaction = current_user.transactions.find(params[:id])
    authorize @transaction
  end
end
