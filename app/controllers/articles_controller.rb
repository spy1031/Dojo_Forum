class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  def index
    @articles = Article.where("status = ?", true).page(params[:page]).per(20)
  end

  def new
    @article = Article.new
  end

  def show
    @article.views_count +=1
    @article.save!
    @collection = current_user.collections.find_by(article_id: @article.id)
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

  def edit
    if current_user != @article.user
      redirect_to root_path
    end
  end

  def update
    if current_user != @article.user
      redirect_to root_path
    end

    if @article.update(article_params)
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
    else
      flash[:alert] = @article.errors.full_messages.to_sentence 
    end
  end

  def destroy
    if current_user.role == "admin" || current_user == @article.user
      @article.destroy
      flash[:notice] = "成功刪除貼文"
    else
      flash[:alert] = "權限不符"
    end

    redirect_to articles_path
  end

  def feeds
    @user_count = User.count 
    @article_count = Article.count
    @reply_count = Reply.count

    @ranked_users = User.order(replies_count: :desc).limit(10)
    @ranked_articles = Article.order(replies_count: :desc).limit(10)
  end

  def sort
    @attr = params[:attr]
    @order = params[:order]
    if params[:category_id]
      @category_id = params[:category_id]
      @category = Category.find(@category_id)
      @articles = Article.where("status = ? AND category_id = ? ", true, @category_id).order(params[:attr]+" "+params[:order]).page(params[:page]).per(20)
    else
      @articles = Article.where("status =? ", true).order(params[:attr]+" "+params[:order]).page(params[:page]).per(20)
    end
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
