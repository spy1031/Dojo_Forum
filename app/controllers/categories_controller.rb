class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]


  def show
    @articles = @category.articles.page(params[:page]).per(20)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
