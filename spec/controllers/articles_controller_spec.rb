require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  render_views

  describe "GET feeds" do  
    before do
      user_list = create_user_list
      article_list = create_article_list(user_list)
      create_reply(user_list, article_list)
      sign_in(user_list[0])
      get :feeds
    end
    


    describe "check" do
      it "we have user count,reply count,and article count info in view template" do
        
        expect(assigns(:user_count)).to eq(15)
        expect(assigns(:article_count)).to eq(15)
        expect(assigns(:reply_count)).to eq(55)
      end

      it "top 10 user's and article's rank is correct" do
        expect(assigns(:ranked_users).first.name).to eq("user1")
        expect(assigns(:ranked_users).last.name).to eq("user10")
        expect(assigns(:ranked_articles).first.title).to eq("article1")
        expect(assigns(:ranked_articles).last.title).to eq("article10")
      end
    end
  end
end