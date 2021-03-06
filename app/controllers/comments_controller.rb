class CommentsController < ApplicationController
  before_action :signed_in_user, :set_talk

  def create
    @comment = @talk.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @talk }
        format.js
      else
        format.html { render 'talks/show' }
        format.js
      end
    end
  end

  private

  def set_talk
    @talk = Talk.find(params[:talk_id])
  end

  def comment_params
    params.require(:comment).permit(:comment).merge(user: current_user)
  end
end
