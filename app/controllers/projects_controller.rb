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
    @token = Token.find_by(project_id: @project.id)
    @transaction = Transaction.where(token_id: Token.where(project_id: @project.id)).count
    @total_amount_invested = @transaction * @token.unit_price
    @total_amount_available = @project.number_of_tokens * @token.unit_price
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end
end
