class UsersController < ApplicationController
  before_action :authenticate_user!, only: :update
  
  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    return render text: 'Not Allowed', status: :forbidden unless @user == current_user || current_user.admin?
    @user.update_attributes(user_params)
    if @user.valid?
      redirect_to root_path
     else
      render :edit, status: :unprocessable_entity
    end  
  end
end

private

def user_params
  params.require(:user).permit(:public_profile)
end
