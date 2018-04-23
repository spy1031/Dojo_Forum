class UsersController < ApplicationController
  before_action :set_user

  def edit
    if @user != current_user 
      flash[:alert] = "權限錯誤"
      redirect_back(fallback_location: root_path)
    end
  end

  def articles
    @articles = @user.articles.where("status = ? ", true)
  end

  def drafts
    @articles = @user.articles.where("status = ? ", false)
  end

  private

  def set_user
    @user = User.find(params[:id])  
  end
end
