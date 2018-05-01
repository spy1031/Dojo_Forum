class Api::V1::ArticlesController < ApiController
  before_action :authenticate_user!, except: :index
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    if current_user == nil
      @articles = Article.where("status = ? AND authority = ?", true, 1)
    else 
      @articles = Article.where("status = ?", true).check_authority(current_user)
    end
    render json: @articles
  end

  def show
    if @article.status == false
      if current_user != @article.user
        render json: {
          errors: "文章尚未發佈"
        }
      else
        render json: @article
      end
    elsif @article.authority == 1 || (@article.authority == 2 && current_user.friend?(@article.user) ==3)
      @article.views_count +=1
      @article.save!
      render json: @article
    else
      render json: {
        errors: "權限不足"
      }
    end
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.last_reply_time = Time.now.localtime
    if params[:draft]
      @article.status = false
      if @article.save
        render json: {
          message: "Article save as draft successfully",
          result: @article
        }
      else
        render json: {
          errors: @article.errors
        }
      end
    else
      @article.status = true
      if @article.save
        render json: {
          message: "Article post successfully",
          result: @article
        }
      else
        render json: {
          errors: @article.errors
        }
      end
    end
  end

  private

  def article_params
    params.permit(
      :title,
      :content,
      :authority,
      :category_id,
      :image,
      )
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
