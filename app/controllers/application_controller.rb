class ApplicationController < ActionController::Base
  def request_admin
    if !current_user.admin?
      flash[:notice] = 'Only admin can do it'
      redirect_to root_path
    end
  end
end
