class Post < ApplicationRecord

  has_one_attached :post_image
  has_many :tag_posts,dependent: :destroy
  has_many :tags,through: :post_tags
  belongs_to :user
  has_many :reviews

  is_impressionable counter_cache: true

end