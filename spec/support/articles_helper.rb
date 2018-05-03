module ArticlesHelper

  def create_user_list
    user_list = []
    15.times do |i|
      user = FactoryBot.create(:user, email: FFaker::Internet.email, name: "user#{i}")
      user_list.push(user)
    end
    return user_list
  end

end