class Review < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :user, optional: true
  
  validates :review_title, presence: true
  validates :shop_review, presence: true
  validates :rate, presence: true
end