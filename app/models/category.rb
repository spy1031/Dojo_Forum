class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories, dependent: :restrict_with_error
end