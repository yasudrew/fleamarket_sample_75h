class CommentsController < ApplicationController
  def create
    item_id = params[:item_id]
    @comment = Comment.create(comment_params)
    redirect_to item_path(item_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id,item_id: params[:item_id])
  end
end
