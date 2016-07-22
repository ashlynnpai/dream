class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @place = Place.find(params[:place_id])
    @comment = @place.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "Your comment has been posted."
      redirect_to place_path(@place)
    else
      @comments = @place.comments.reload
      if @comment.errors.full_messages.present?
        flash[:alert] = @comment.errors.full_messages[0]
      else
        flash[:alert] = "Your comment did not post"
      end
      redirect_to :back
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:message, :rating).merge(user: current_user)
  end
end


  