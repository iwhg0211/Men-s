class Post < ApplicationRecord

  has_one_attached :post_image
  has_many :tag_posts

end
