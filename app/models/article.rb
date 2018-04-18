class Article < ApplicationRecord
  belongs_to :user, counter_cache: :true
  belongs_to :category
  has_many :replies

end
