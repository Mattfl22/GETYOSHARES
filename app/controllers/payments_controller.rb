class PaymentsController < ApplicationController
  def new
    @transaction = current_user.transactions.where(state: 'pending').find(params[:transaction_id])
    authorize @transaction, :create?
  end
end