class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def request_admin
    if !current_user.admin?
      flash[:notice] = 'Only admin can do it'
      redirect_to root_path
    end
  end
end
