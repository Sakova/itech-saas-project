module ApplicationHelper
  def organization_name
    Organization.find(session[:organization_id]).name
  end
end
