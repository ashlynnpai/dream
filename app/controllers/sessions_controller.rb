class SessionsController < Devise::SessionsController
  after_action :remove_notice, only: [:create, :destroy]
  
  def new
    if params[:redirect_to]
      session[:user_return_to] = params[:redirect_to]
    end
    super  
  end

  private

  def remove_notice
    flash[:notice] = nil
  end
end