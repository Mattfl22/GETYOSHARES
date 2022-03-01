class ProjectsController < ApplicationController
  before_action :find_project, only: [:index, :show]

  def index
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
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end
end
