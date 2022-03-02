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
  end


  private

  def find_project
    @project = Project.find(params[:id])
  end
end
