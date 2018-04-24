class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :articles
  has_many :replies, dependent: :destroy
  has_many :friendships, ->{where status: 3}, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, ->{where status: 3}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :invers_friends, through: :inverse_friendships, source: :user

  has_many :friend_requests, ->{where status: 2}, class_name: "Friendship", dependent: :destroy
  has_many :requests, through: :friend_requests, source: :user
  has_many :invites, through: :friend_requests, source: :friend

  def admin?
    self.role == "admin"
  end

  # 1 repsent friend, 2 represnt wait user agree, 3 represent self agree
  def friend?(user)
    if self.friends.include?(user) || self.invers_friends.include?(user) || self == user
      return 3
    elsif self.requests.include?(user)
      return 2
    elsif self.invites.include?(user)
      return 1 
    else
      return 0
    end
  end
end
