class UsersController < ApplicationController

  def articles
    @user = User.find(params[:id])  
    @articles = @user.articles
  end
end
