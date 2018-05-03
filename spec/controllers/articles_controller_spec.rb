require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  render_views

  describe "GET feeds" do
    before do
      user1 = (create(:user))
      user2 = (create(:user))
      user3 = (create(:user))

      article1 = create(:article, user: user1)
      article2 = create(:article, user: user2)
      article3 = create(:article, user: user3)

      reply1 = create(:reply, user: user1, article: article1)
      reply2 = create(:reply, user: user2, article: article2)
      sign_in(user1)

    end

    it "check we have user count,reply count,and article count info in view template" do
      get :feeds
      expect(assigns(:user_count)).to eq(3)
      expect(assigns(:article_count)).to eq(3)
      expect(assigns(:reply_count)).to eq(2)
    end

    
  end
end