class DashboardsController < ApplicationController
# needed so that the user never see its ID in the url
# dashboards controller need to be plural even though the route dashboard is singular
  def show
    @user = current_user
    authorize(:dashboard, :show?)
  end
end
