class BillingController < ApplicationController

  before_action :authenticate_user!

  def index
   @user=current_user.email
  end

  def new_card
    respond_to do |format|
      format.js
    end
  end

end
