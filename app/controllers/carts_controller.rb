class CartsController < ApplicationController
  before_action :authenticate_user!

  def create
    transaction = Transaction.find(params[:transaction_id])
    @cart = transaction.carts.new(cart_params)
    authorize @cart

    checkout_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        name: "token.sku",
        amount: token.price_cents,
        currency: 'usd',
        quantity: cart.quantity
      }],
      # success_url: project_transaction_url(@transaction.token.project, @transaction),
      # cancel_url: project_transaction_url(@transaction.token.project, @transaction)
    )

    @cart.update(checkout_session_id: checkout_session.id)
    # binding.pry

    redirect_to checkout_session[:url]
  end

  def show
  end

  def cart_params 
    params.require(:cart).permit(:quantity, :state, :checkout_session_id)
  end
end
