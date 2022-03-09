class DashboardsController < ApplicationController
# needed so that the user never see its ID in the url
# dashboards controller need to be plural even though the route dashboard is singular
  def show
    @user = current_user
    authorize(:dashboard, :show?)
    projects = @user.transactions.group_by{ |t| t.token.project.name}
    @project_informations = []
    projects.each do |project_name, transactions|
      project = { project_name: project_name, transactions: transactions.count }
      @project_informations << project
    end
  end

  def create_playlist(current_user)
    create_spoti_playlist(current_user)
  end
end
