class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.last_reply_time = Time.now.localtime
    if params[:draft]
      @article.status = 0
    else
      @article.status = 1
    end

    @article.save!
    flash[:notice] = @article.status ? "成功發布文章" : "成功儲存草稿"
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(
      :title,
      :content,
      :authority,
      :category_id)
  end
end
