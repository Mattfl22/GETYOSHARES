class CartsController < ApplicationController
  before_action :authenticate_user!

  def create
    # token = Token.find(params[:token_id])

    @cart = current_user.carts.where(state: "pending").first_or_initialize
    authorize @cart

    @cart.quantity = params[:quantity]
    @cart.state = 'pending'
    @cart.save!

    @project = Project.find(params[:project_id])

    params[:quantity].to_i.times do
      token = @project.tokens.find { |token| token if !token.bought? }
      transaction = Transaction.create!(token: token, amount: token.price, user: current_user, cart_id: @cart.id)
    end
    checkout_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        name: @project.user.artist_name,
        amount: @cart.transactions.first.token.price_cents,
        currency: 'usd',
        quantity: @cart.quantity,
        images: [@project.photo]
      }],
      success_url: cart_url(@cart),
      cancel_url: cart_url(@cart)
    )

    @cart.update(checkout_session_id: checkout_session.id)
    redirect_to checkout_session[:url]
  end

  def show
    @cart = current_user.carts.find(params[:id])
    authorize @cart
  end
end
