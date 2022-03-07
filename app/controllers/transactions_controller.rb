class TransactionsController < ApplicationController
  def create
    token = Token.find(params[:token_id])
    @transaction  = Transaction.create!(token: token, amount: token.price, state: 'pending', user: current_user)
    authorize @transaction
    # redirect_to new_project_transaction_payment_path(@transaction.token.project, @transaction)

    # CECILE, COMMENT FAIRE??
    # stripe = Stripe(ENV['STRIPE_PUBLISHABLE_KEY'])
    # stripe.redirectToCheckout({
    #   sessionId: @transaction.checkout_session_id
    # });
  end

  def show
    @transaction = current_user.transactions.find(params[:id])
    authorize @transaction
  end
end
