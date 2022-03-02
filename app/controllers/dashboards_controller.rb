class DashboardsController < ApplicationController
# needed so that the user never see its ID in the url
# dashboards controller need to be plural even though the route dashboard is singular
  def show
    @user = current_user
    authorize(:dashboard, :show?)
    @transactions_per_artist = @user.transactions.group_by{ |t| t.token.project.user.artist_name}

    @project_informations = []
    @tokens_per_project = @user.tokens.group_by{ |t| t.project.name}
    @tokens_per_project.each do |project_name, token_id, unit_price, project_id|
      project = {project_name: project_name, token_id: token_id, unit_price: unit_price.to_i, project_id: project_id}
      @project_informations << project
    end
    
    @transaction_informations = []
    @transactions_per_artist.each do |artist_name, transactions|
      transaction = { artist_name: artist_name, transactions: transactions.count }
      @transaction_informations << transaction
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
