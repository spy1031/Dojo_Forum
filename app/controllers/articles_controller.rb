class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end
end
