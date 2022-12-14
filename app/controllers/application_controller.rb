class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def request_admin
    if !current_user.admin?
      flash[:alert] = 'Only admin can do it'
      redirect_to root_path
    end
  end
end
