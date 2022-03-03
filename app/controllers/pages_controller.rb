class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
    @selected_artists = User.where(id: [2, 1, 4])
    # cardi_b = User.find(2).artist_name
    # cardi_b_project = Project.find_by(user_id: cardi_b)
    # cardi_b_tokens = Token.find_by(project_id: cardi_b_project)
    # cardi_b_transactions = Transaction.where(token_id: Token.where(project_id: project.id)).count

    # faire la formule qui permet, à partir de l'ID de l'artiste de trouver 
    # son nom de scene et le nb de tokens restants
    # nom de scene = User.artist_name
    # tokens restants = Project.nb_of_tokens - Transaction.where(token_id: Token.where(project_id: project.id)).count
  end

  # @artist_id = @artist_name.id
  # @artist_project = Project.find_by(user_id: @artist_id)
  # @project_tokens = @artist_project.number_of_tokens
  # @project_transactions = Transaction.where(token_id: Token.where(project_id: @artist_project)).count

end
