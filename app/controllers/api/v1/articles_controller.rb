class Api::V1::ArticlesController < ApiController
  before_action :authenticate_user!, except: [:index]
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
    if @article.authority == 1 || (@article.authority == 2 && current_user.friend?(@article.user) ==3)
      @article.views_count +=1
      @article.save!
      render json: @article
    else
      render json: {
        errors: "權限不足"
      }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
end
