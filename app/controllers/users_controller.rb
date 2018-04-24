class UsersController < ApplicationController
  before_action :set_user

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
    @articles = @user.articles.where("status = ? ", true)
  end

  def replies
    @replies = @user.replies
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
end
