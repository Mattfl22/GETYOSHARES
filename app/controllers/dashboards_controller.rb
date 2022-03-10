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

  def create_playlist
    auth = request.env['omniauth.auth']
    authorize(:dashboard, :create_playlist?)

    current_user.token = auth.credentials.token
    current_user.uid = auth.uid
    current_user.save

    CreateSpotifyPlaylistService.new(current_user).call

    flash[:notice] = "Playlist added with success"
    redirect_to dashboard_path
  end
end
