class TagPost < ApplicationRecord

  belongs_to :tag
  belongs_to :post
  
  validates :tag_id, presence: true
  validates :post_id, presence: true
  validates :tag_id, uniqueness: { scope: :post_id }

end