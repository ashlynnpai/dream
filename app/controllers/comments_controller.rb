class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @place = Place.find(params[:place_id])
    @comment = @place.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "Your comment has been posted."
      respond_to do |format| 
        format.html { redirect_to place_path(@place) }
        format.js
      end
    else
      @comments = @place.comments.reload
      if @comment.errors.full_messages.present?
        flash[:alert] = @comment.errors.full_messages[0]
      else
        flash[:alert] = "Your comment did not post"
      end
      #redirect_to :back
      respond_to do |format| 
        format.html { redirect_to :back }
        format.js
      end
    end
  end
  
  def update
    @comment = Comment.find(params[:id])
    @place = @comment.place
    return render text: 'Not Allowed', status: :forbidden unless @comment.user == current_user || current_user.admin?
    @comment.update_attributes(comment_params)
    if @comment.valid?
      flash[:notice] = "Your comment has been updated."
      redirect_to place_path(@place)
#       respond_to do |format| 
#         format.html { redirect_to place_path(@place) }
#         format.js
#      end
    else
      @comments = @place.comments.reload
      if @comment.errors.full_messages.present?
        flash[:alert] = @comment.errors.full_messages[0]
      else
        flash[:alert] = "Your comment did not update"
      end
      #redirect_to :back
#       respond_to do |format| 
#         format.html { redirect_to :back }
#         format.js
#      end
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:message, :rating).merge(user: current_user)
  end
end


 
  