class RepliesController < ApplicationController

  def create
    @reply = current_user.replies.build(reply_params)
    @reply.save!
    redirect_to article_path(params[:reply][:article_id])
  end

  private

  def reply_params
    params.require(:reply).permit(
      :content,
      :article_id)
  end
end
