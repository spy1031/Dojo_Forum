require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  render_views

  describe "GET feeds" do
    before do
      user_list = create_user_list
      article_list = create_article_list(user_list)
      create_reply(user_list, article_list)
      sign_in(user_list[0])

    end

    it "check we have user count,reply count,and article count info in view template" do
      get :feeds
      expect(assigns(:user_count)).to eq(15)
      expect(assigns(:article_count)).to eq(15)
      expect(assigns(:reply_count)).to eq(55)
    end


  end
end