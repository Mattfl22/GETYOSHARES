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

  def show_tokens

    # @tokens = Token.joins(:transactions).joins(:users).where(transactions: {user: current_user})
    # raise
    # projects.keys.in_groups_of(1,nil).each do |p|
    #   puts p[0]     
    # end
  end
  # helper_method :show_tokens

end
