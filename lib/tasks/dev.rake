namespace :dev do 

  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      
      user = User.new(
        email: "#{name}@example.co",
        password: "12345678",
        role: "normal"
      )

      user.save!
      puts user.email
    end
  end

end