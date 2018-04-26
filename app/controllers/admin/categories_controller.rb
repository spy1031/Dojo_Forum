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

  def update
    @category = Category.find(params[:id])
    @category.update(name: params[:category_name])
    render :json => {:id => @category.id, :name => @category.name}
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.articles.count == 0
      @category.destroy
      flash[:notice] = "成功刪除文章分類"
      redirect_to admin_root_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
