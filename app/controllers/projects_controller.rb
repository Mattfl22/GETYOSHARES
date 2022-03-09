class ProjectsController < ApplicationController
  before_action :find_project, only: [:show]

  def index
    @projects = policy_scope(Project)
    # we search by genre or artist name
    if params[:query].present?
      sql_query = " \
      products.genre ILIKE :query \
      OR users.artist_name ILIKE :query \
    "
      @projects = Project.joins(:products, :user).where(sql_query, query: "%#{params[:query]}%").distinct
    else
      @projects = Project.all
    end
  end

  def new
    @project = Project.new
    authorize @project
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id

    if @project.save!
      redirect_to dashboard_path(current_user)
    else
      render :new
    end
    authorize @project
  end

  def update
  end

  def show
    authorize @project
    # variables for piechart n°1
    distribution_share = @project.average_distribution_share
    investor_share = @project.number_of_tokens
    artist_share = 100 - distribution_share - investor_share
    @shares = { "Distributor's share": distribution_share, "Investor's share": investor_share, "Artist's share": artist_share }

    @cart = current_user.carts.new
  end

  def project_params
    params.require(:project).permit(
      abyme_attributes, :id, :user_id, :name, :description, :distributor, :release_date, :average_distribution_share,
      :expected_audio_streams_year, :expected_video_streams_year, :number_of_tokens, :photo,
      tokens_attributes: [:price_cents],
      products_attributes: [
        :id, :genre, :spotify_id, :description, :_destroy, tracks_attributes: [
          :id, :title, :youtube_id, :_destroy
        ]
      ]
    )
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end
end
