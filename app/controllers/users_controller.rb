class UsersController < ApplicationController
  before_action :authenticate_user!, only: :update
  
  def show
    @user = User.find(params[:id])
    @buckets = @user.buckets.todo
    @completed_buckets = @user.buckets.done
    @comments = @user.comments
    if @user == current_user || @user.public_profile?
      render :show
    else 
      render text: "Sorry, that member's profile is private.", status: :forbidden
    end     
  end
  
  def update
    @user = current_user
    return render text: 'Not Allowed', status: :forbidden unless @user == current_user || current_user.admin?
    @user.update_attributes(user_params)
    if @user.valid?
      redirect_to dashboard_path
     else
      render text: 'Not Updated', status: :unprocessable_entity
    end  
  end
end

private

def user_params
  params.require(:user).permit(:public_profile, :notify_on_comment)
end
