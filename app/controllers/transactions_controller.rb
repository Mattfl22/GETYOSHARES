class TransactionsController < ApplicationController
  def create
    token = Token.find(params[:token_id])
    @transaction  = Transaction.create!(token: token, amount: token.price, state: 'pending', user: current_user)
    authorize @transaction

    checkout_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        name: "token.sku",
        amount: token.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: project_transaction_url(@transaction.token.project, @transaction),
      cancel_url: project_transaction_url(@transaction.token.project, @transaction)
    )

    @transaction.update(checkout_session_id: checkout_session.id)
    # binding.pry

    redirect_to checkout_session[:url]
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
