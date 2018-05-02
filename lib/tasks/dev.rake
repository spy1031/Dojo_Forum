namespace :dev do 

  task fake_user: :environment do
    User.where("role != ?","admin").destroy_all
    url = "https://uinames.com/api/?ext&region=england"
    15.times do |i|
      
      response = RestClient.get(url)
      data = JSON.parse(response.body)

      user = User.new(
        email: FFaker::Name::first_name + "@example.com",
        password: "123456",
        role: "normal",
        name: FFaker::Name::first_name,
        introduction: FFaker::Lorem::sentence(30),
        gender: ["male","female"].sample,
        avatar: data["photo"]
      )

      user.save!
      puts user.email
    end
  end

  task fake_article: :environment do
    Article.destroy_all
    User.all.each do |user|
      category = Category.all.sample
      article = user.articles.build(
        title: FFaker::Book::title,
        content: FFaker::Lorem::sentence(100),
        authority: 1,
        status: true,
        last_reply_time: Time.zone.now,
        category_id: category.id)
      article.save!
      puts "#{user.name} create a article"
    end
    
  end
end