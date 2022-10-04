class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if current_user
      @org = current_user.organizations[0]
      @projects = Project.by_user_plan_and_organization(@org.id, current_user)
      params[:organization_id] = @org.id
    end
  end
end
