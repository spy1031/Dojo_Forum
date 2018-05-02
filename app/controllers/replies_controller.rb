class RepliesController < ApplicationController
  before_action :set_reply, only: [:update, :destroy]
  before_action :authenticate_user!
  def create
    @reply = current_user.replies.build(reply_params)
    @reply.save!
    flash[:notice] = "成功新增回覆"
    redirect_to article_path(params[:reply][:article_id])
  end

  def destroy
    if current_user.admin? || @reply.user == current_user || @reply.user == @reply.article.user 
      @reply.destroy
      flash[:alert] = "成功刪除回覆"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if  @reply.user == current_user 
      @reply.content = params[:content]
      @reply.save!
      render :json => { :reply_id => @reply.id }
    end
  end

  private

  def reply_params
    params.require(:reply).permit(
      :content,
      :article_id)
  end

  def set_reply
    @reply = Reply.find(params[:id])
  end
end
