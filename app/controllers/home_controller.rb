class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :features]

  def index
    flash.now[:notice] = "You will receive an email with instructions" +
      "for how to confirm your email address in a few minutes." if params[:notice].present?
    if current_user
      @org = current_user.organizations[0]
      @projects = Project.by_user_plan_and_organization(@org.id, current_user)
      params[:organization_id] = @org.id
    end
  end

  def features

  end

  private

  def index_params
    params.require(:val).permit(:name)
  end
end
