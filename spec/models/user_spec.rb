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
    
    expect(user1.friend?(user2)).to eq (0)
    
    friendships1 = user1.friendships.create(friend_id: user2.id, status: 2)
    expect(user2.friend?(user1)).to eq (1)
    expect(user1.friend?(user2)).to eq (2)

    friendships1.update(status: 3)
    expect(user2.friend?(user1)).to eq (3)
    expect(user1.friend?(user2)).to eq (3)

  end
end