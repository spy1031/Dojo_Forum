class Collection < ApplicationRecord
  validates :article_id, uniqueness: { scope: :user_id }
  belongs_to :user
  belongs_to :article
end
