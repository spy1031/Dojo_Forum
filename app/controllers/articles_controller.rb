class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_article, only: [:show, :destroy]
  def index
    @articles = Article.where("status = ?", true).page(params[:page]).per(20)
  end

  def new
    @article = Article.new
  end

  def show
    @article.views_count +=1
    @article.save!
    @reply = Reply.new
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.last_reply_time = Time.now.localtime
    if params[:draft]
      @article.status = false
      @article.save!
      flash[:notice] = "成功儲存草稿"
      redirect_to drafts_user_path(current_user)
    else
      @article.status = true
      @article.save!
      flash[:notice] = "成功發布文章"
      redirect_to article_path(@article)
    end

    
  end

  def destroy
    if current_user.role == "admin" || current_user == @article.user
      @article.destroy
      flash[:notice] = "成功刪除貼文"
    else
      flash[:alert] = "權限不符"
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def article_params
    params.require(:article).permit(
      :title,
      :content,
      :authority,
      :category_id,
      :image)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
