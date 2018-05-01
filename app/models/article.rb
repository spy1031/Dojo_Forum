class Article < ApplicationRecord
  validates_presence_of :title, :content, :authority

  belongs_to :user
  belongs_to :category
  has_many :replies, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :collectors, through: :collections, source: :user

  def self.check_authority(user)
    self.where("authority = ? OR  user_id = ?", 1, user.id).or(where("authority = ? AND user_id IN (?)", 2, user.friends + user.inverse_friends))
  end
end
