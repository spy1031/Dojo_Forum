class UsersController < ApplicationController
  before_action :set_user

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
