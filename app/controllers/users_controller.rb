class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!
  before_action :authenticate_self_user!, except: [:articles, :replies]
  def edit
    if @user != current_user 
      flash[:alert] = "權限錯誤"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "成功更新個人資料"
      redirect_to articles_user_path
    else
      flash[:alert] = @user.errors.full_messages.to_sentence 
    end
  end

  def articles
    @articles = @user.articles.where("status = ?", true).check_authority(current_user)
  end

  def replies
    @replies = @user.replies
  end

  def collects
    @collections = @user.collections
  end

  def drafts
    @articles = @user.articles.where("status = ? ", false)
  end

  private

  def set_user
    @user = User.find(params[:id])  
  end

  def user_params
    params.require(:user).permit(
      :name,
      :introduction,
      :avatar)
  end

  def authenticate_self_user!
    if current_user != @user
      flash[:alert] = "The information wasnot belong to you."
      redirect_back(fallback_location: root_path)
    end
  end
end
