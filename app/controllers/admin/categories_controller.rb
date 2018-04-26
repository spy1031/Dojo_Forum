class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    flash[:notice] = "成功新增文章分類"
    redirect_to admin_root_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
