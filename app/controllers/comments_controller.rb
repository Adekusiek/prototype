class CommentsController < ApplicationController
  def create
    Comment.create(comment_params)
    redirect_to event_path(params[:event_id])
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to event_path(comment.event)
  end

  private
  def comment_params
    params.permit(:text, :event_id).merge(user_id: current_user.id)
  end
end
