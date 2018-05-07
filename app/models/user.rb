class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :articles, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :collect_articles, through: :collections, source: :article
  has_many :replies, dependent: :destroy
  has_many :friendships, ->{where status: 3}, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, ->{where status: 3}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :friend_requests, ->{where status: 2}, class_name: "Friendship", dependent: :destroy
  has_many :requests, through: :friend_requests, source: :friend
  has_many :friend_invites, ->{where status: 2}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :invites, through: :friend_invites, source: :user

  before_create :generate_authentication_token
  
  def admin?
    self.role == "admin"
  end

  # 3 repsent friend, 2 represnt wait user agree, 1 represent wait self agree
  def friend?(user)
    if self.friends.include?(user) || self.inverse_friends.include?(user) || self == user
      return 3
    elsif self.requests.include?(user)
      return 2
    elsif self.invites.include?(user)
      return 1 
    else
      return 0
    end
  end

  def collector?(article)
    article.collectors.include?(self)
  end

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end

  def self.get_facebook_user_data(access_token)
    url = "https://graph.facebook.com/me"
    response = RestClient.get url, {params: { access_token: access_token }}
    data = JSON.parse(response.body)

    if response.code == 200
      data
    else
      Rails.logger.warn(data)
      nil
    end
  end

  def self.from_omniauth(auth_hash)
    user = User.find_by_fb_uid(auth_hash.uid)
    puts auth_hash
    if user
      user.fb_token = auth_hash.credentials.token
      user.save!
      puts "case1"
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email(auth_hash.info.email)
    if existing_user
      existing_user.fb_uid = auth_hash.uid
      existing_user.fb_token = auth_hash.credentials.token
      existing_user.save!
      puts "case2"
      return existing_user
    end
    puts "case3"
    # Case 3: Create new password
    user = User.new
    user.fb_uid = auth_hash.uid
    user.fb_token = auth_hash.credentials.token
    user.name = auth_hash.info.email.split('@')[0]
    user.email = auth_hash.info.email
    user.password = Devise.friendly_token[0,20]
    user.save!
    return user
  end
end
