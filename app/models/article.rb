class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :replies, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :collectors, through: :collections, source: :user
end
