class ProjectsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :verify_organization
  before_action :free_plan_can_only_have_one_project, only: [:new, :create]

  def index
    @projects = Project.by_user_plan_and_organization(params[:organization_id], current_user)
  end

  def show
    session[:project_id] = @project.id
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    @project.organization_id = params[:organization_id]
    if @project.save
      flash[:notice] = "Project created successfully"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project was successfully updated"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = "Project was successfully destroyed"
    redirect_to root_path
  end

  private

  def set_project
    @project = Project.set_project_check(params[:id], @organization)
  end

  def project_params
    params.require(:project).permit(:title, :details, :expected_completion_date)
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def verify_organization
    unless params[:organization_id] == current_user.organizations[0].id.to_s
      redirect_to root_path, notice: 'You are not authorized to access not your organization'
    end
  end

  def free_plan_can_only_have_one_project
    if @organization.projects.count <= 1 && @organization.plan == 'free'
      redirect_to root_path, notice: 'Free plans can not have more than one project'
    end
  end


end
