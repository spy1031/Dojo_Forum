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

end