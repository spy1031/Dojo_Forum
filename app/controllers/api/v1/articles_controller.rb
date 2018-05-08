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
        render json: {
          article: @article,
          category: @article.categories
        }
      end
    elsif @article.authority == 1 || (@article.authority == 2 && current_user.friend?(@article.user) ==3)
      @article.views_count +=1
      @article.save!
      render json: {
          article: @article,
          category: @article.categories
        }
    else
      render json: {
        errors: "權限不足"
      }
    end
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.last_reply_time = Time.now.localtime
    @article.save!

    if params[:draft]
      @article.status = false
      if @article.save
        render json: {
          message: "Article save as draft successfully",
          article: @article,
          category: @article.categories
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
          article: @article,
          category: @article.categories
        }
      else
        render json: {
          errors: @article.errors
        }
      end
    end
  end

  def update
    if current_user != @article.user
      render json: {
        errors: "Your are not owner."
      }
    elsif @article.update(article_params)
      if params[:draft]
        @article.status = false
        @article.save!
        render json: {
          message: "Update article successfully.",
          result: @article
        } 
        
      else
        @article.status = true
        @article.save!
        render json: {
          message: "Update article successfully.",
          result: @article
        } 
        
      end
    else
      render json: {
          errors: @article.errors
      } 
    end
  end

  def destroy
    if current_user.role == "admin" || current_user == @article.user
      @article.destroy
      render json: {
        message: "destroy article successfully."
      }
    else
      render json: {
        errors: "權限不符"
      } 
    end
  end

  private

  def article_params
    params.permit(
      :title,
      :content,
      :authority,
      :image,
      :category_ids =>[]
      )
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
