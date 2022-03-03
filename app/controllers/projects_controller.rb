class ProjectsController < ApplicationController
  before_action :find_project, only: [:show]

  def index
    @projects = policy_scope(Project)
  end

  def new
  end

  def edit
  end

  def create
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
    # variables for piechart n°2


  end

  private

  def find_project
    @project = Project.find(params[:id])
  end
end
