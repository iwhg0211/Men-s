class Post < ApplicationRecord

  has_one_attached :post_image
  has_many :tag_posts, dependent: :destroy
  has_many :tags, through: :tag_posts

  belongs_to :user

  is_impressionable counter_cache: true

  validates :shop_name, presence: true
  validates :shop_explanation, presence: true

  # geocoded_by :address
  # after_validation :geocode

  def save_tag(tag_list)
    #self.tags.pluck(:tag_name) unless self.tags.nil?
    if self.tags.pluck(:tag_name) == tag_list
      tag_posts_records = TagPost.where(post_id: self.id)
      tag_posts_records.destroy_all
    end

    tag_list.each do |tag|
      inspected_tag = Tag.where(tag_name: tag).first_or_create
      self.tags << inspected_tag
    end

    # current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # #binding.pry
    # old_tags = current_tags - sent_tags
    # new_tags = sent_tags - current_tags

    # old_tags.each do |old|
    # self.tags.delete Tag.find_by(tag_name: old)
    # end

    # new_tags.each do |new|
    # new_post_tag = Tag.find_or_create_by(tag_name: new)
    # #undefined method `name' for #<Tag id: nil, tag_name: "abura", created_at: nil, updated_at: nil>
    # self.tags << new_post_tag
  #   end

  end

end