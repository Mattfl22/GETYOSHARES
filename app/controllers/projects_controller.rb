class ProjectsController < ApplicationController
  before_action :find_project, only: [:show]

  def index
    @projects = Project.all
  end

  def new
  end

  def edit
  end

  def create
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
