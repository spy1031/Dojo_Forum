require 'rails_helper'

RSpec.describe User, type: :model  do
  describe 'Association' do
    it { should have_many(:replies) }
    it { should have_many(:articles) }
    it { should have_many(:collections) }
    it { should have_many(:friendships) }
  end

  describe 'Validation' do
    subject { FactoryBot.create(:user) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
  end

  it "should detect friendships correctlly" do
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    
    expect(user1.friend_state(user2)).to eq (0)
    
    friendships1 = user1.friendships.create(friend_id: user2.id, status: 2)
    expect(user2.friend_state(user1)).to eq (1)
    expect(user1.friend_state(user2)).to eq (2)

    friendships1.update(status: 3)
    expect(user2.friend_state(user1)).to eq (3)
    expect(user1.friend_state(user2)).to eq (3)

  end

  it "should get_facebook_user_data work(vcr version)" do
    fb_config = Rails.application.config_for(:facebook)
    vcr_config = 
    VCR.use_cassette 'get facebook user data' do
      expect(User.get_facebook_user_data(fb_config["access_token"])).to eq({
        "name" => "蘇沛宇",
        "id" => "807899102562905"
      })
    end
  end

  it "should from_omniauth work" do
    user1 = create(:user, fb_uid: "123", fb_token: "123")
    user2 = create(:user, email: "spec@456")
    fb_data1 = { "email" => "spec@123", "id" =>"123"}
    fb_data2 = { "email" => "spec@456", "id" =>"456"}
    fb_data3 = { "email" => "spec@789", "id" =>"789"}
    auth_hash1 = OmniAuth::AuthHash.new({
      uid: fb_data1["id"],
      info: {  email: fb_data1["email"] },
      credentials: {
        token: user1.fb_token,
      }
    })
    auth_hash2 = OmniAuth::AuthHash.new({
      uid: fb_data2["id"],
      info: {  email: fb_data2["email"] },
      credentials: {
        token: user2.fb_token,
      }
    })
    auth_hash3 = OmniAuth::AuthHash.new({
      uid: fb_data3["id"],
      info: {  email: fb_data3["email"] },
      credentials: {
        token: "789",
      }
    })


    expect(User.from_omniauth(auth_hash1)).to eq(user1)
    expect(User.from_omniauth(auth_hash2)).to eq(user2)
    expect(User.from_omniauth(auth_hash3).persisted?).to eq(true)
  end
end