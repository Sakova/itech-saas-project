class HomeController < ApplicationController
  def index
    @org = current_user.organizations[0] if current_user
  end
end
