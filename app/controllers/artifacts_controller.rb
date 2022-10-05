class ArtifactsController < ApplicationController
  before_action :set_artifact, only: [:show, :edit, :destroy]
  before_action :set_organization, only: [:new]

  def index
    @artifacts = Artifact.all
  end

  def show
  end

  def new
    @artifact = Artifact.new
    @artifact.project_id = @organization.projects[0].id
  end

  def edit
  end

  def create
    @artifact = Artifact.new(artifact_params)

    if @artifact.save
      @artifact.update(key: @artifact.file.url)
      flash[:notice] = "Artifact created successfully"
      redirect_to organization_project_path(organization_id: session[:organization_id], id: @artifact.project_id)
    else
      render 'new'
    end
  end

  def destroy
    @artifact.destroy
    redirect_to organization_project_path(organization_id: session[:organization_id], id: @artifact.project_id)
  end


  private

  def set_artifact
    @artifact = Artifact.find(params[:id])
  end

  def artifact_params
    params.require(:artifact).permit(:name, :project_id, :file)
  end

  def set_organization
    @organization = Organization.find(session[:organization_id])
  end
end