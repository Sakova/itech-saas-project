class MembersController < ApplicationController
  before_action :request_admin, only: [ :index, :create, :destroy ]
  before_action :set_project, only: [:index]
  before_action :set_member, only: [:destroy]

  def index
    @members = @project.members
    @invited = User.where(invited_by: @project.organization.users.find_by(admin: true)).where.not(invitation_accepted_at: nil)
  end

  def create
    @member = Member.new(member_params)
    @member.save!
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def destroy
    @member.destroy!
    flash.now[:notice] = "Member was successfully removed"
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.permit(:project_id, :user_id)
  end
end