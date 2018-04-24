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
end
