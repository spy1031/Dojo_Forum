namespace :dev do 

  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      
      user = User.new(
        email: "#{name}@example.co",
        password: "12345678",
        role: "normal",
        name: name,
        introduction: FFaker::Lorem::sentence(30),
        gender: ["male","female"].sample
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
        title: category.name,
        content: FFaker::Lorem::sentence(100),
        authority: 0,
        status: true,
        last_reply_time: Time.zone.now,
        category_id: category.id)
      article.save!
      puts "#{user.name} create a article"
    end
    
  end
end