module ArticlesHelper

  def create_user_list
    user_list = []
    15.times do |i|
      user = FactoryBot.create(:user, email: FFaker::Internet.email, name: "user#{i+1}")
      user_list.push(user)
    end
    return user_list
  end

  def create_article_list(user_list)
    article_list = []
    i = 0
    user_list.each do |user|
      i +=1
      article_list.push(FactoryBot.create(:article, user: user, title: "article#{i}"))
    end
    return article_list
  end

  def create_reply(user_list, article_list)
    
    for i in 0..9
      ( 10-i ).times do 
        create(:reply, user: user_list[i], article: article_list[i])
      end
    end
    
  end
end