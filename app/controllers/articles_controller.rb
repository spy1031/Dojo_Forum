class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def index
    @articles = Article.page(params[:page]).per(20)
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
    @article.views_count +=1
    @article.save!
    @reply = Reply.new
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
    redirect_to article_path(@article)
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
