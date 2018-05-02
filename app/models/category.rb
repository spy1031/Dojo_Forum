class Category < ApplicationRecord
  has_many :articles,throught: :article_category, dependent: :restrict_with_error
end