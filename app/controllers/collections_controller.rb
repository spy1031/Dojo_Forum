class CollectionsController < ApplicationController
  def create
    @collection = current_user.collections.build(article_id: params[:article_id])
    @collection.save!

  end
end
