class Review < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :user, optional: true
  # optional: true　があれば外部キーのbelongs_to のnilを認める
  
  validates :rate, presence: true
end