class CollectionsController < ApplicationController
  before_action :authenticate_user!
  def create
    @collection = current_user.collections.build(article_id: params[:article_id])
    @collection.save!
    render :json => {collection_id: @collection.id}
  end

  def destroy
    @collection = Collection.find(params[:id])
    @article_id = @collection.article_id
    @collection.destroy
    render :json => {article_id: @article_id}
  end
end
