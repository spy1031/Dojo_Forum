class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :authenticate_user!

  def show
    @articles = @category.articles.where("status =?", true).check_authority(current_user).page(params[:page]).per(20)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
