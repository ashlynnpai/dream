class AdminsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
end