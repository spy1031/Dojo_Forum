class Api::V1::ArticlesController < ApiController
  def index
    if current_user == nil
      @articles = Article.where("status = ? AND authority = ?", true, 1)
    else 
      @articles = Article.where("status = ?", true).check_authority(current_user)
    end
    render json: @articles
  end
end
