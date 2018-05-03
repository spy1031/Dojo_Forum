require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  render_views

  describe "GET feeds" do
    before do
      user_list = create_user_list

      article1 = create(:article, user: user_list[0])
      article2 = create(:article, user: user_list[1])
      article3 = create(:article, user: user_list[2])

      reply1 = create(:reply, user: user_list[0], article: article1)
      reply2 = create(:reply, user: user_list[2], article: article2)
      sign_in(user_list[0])

    end

    it "check we have user count,reply count,and article count info in view template" do
      get :feeds
      expect(assigns(:user_count)).to eq(15)
      expect(assigns(:article_count)).to eq(3)
      expect(assigns(:reply_count)).to eq(2)
    end

    
  end
end