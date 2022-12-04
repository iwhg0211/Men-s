class Tag < ApplicationRecord

  has_many :tag_posts,dependent: :destroy, foreign_key: 'tag_id'#ここのforeign_key: 'tag_id'はどういう記述？
  has_many :posts,through: :post_tags

  validates :name, uniqueness: true, presence: true

end