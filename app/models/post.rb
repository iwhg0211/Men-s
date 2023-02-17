class Post < ApplicationRecord

  has_one_attached :post_image
  has_many :tag_posts, dependent: :destroy
  has_many :tags, through: :tag_posts, dependent: :destroy
  has_many :reviews, dependent: :destroy

  belongs_to :user

  validates :shop_name, presence: true
  validates :shop_explanation, presence: true

  geocoded_by :address
  after_validation :geocode

  #↓投稿のタグの作成のメソッド(user/post_controller.rbのcreateアクションで使用)
  def save_tag(tag_list)
    #self.tags.pluck(:tag_name) unless self.tags.nil?
    if self.tags.pluck(:tag_name) == tag_list
      tag_posts_records = TagPost.where(post_id: self.id)
      tag_posts_records.destroy_all
    end
    #↑もしsaveしタグの名前が存在したら、前に入っていたかぶっているタグを消す(というのであってるかな...)

    tag_list = tag_list - self.tags.pluck(:tag_name)
    #↑tag_listに入っているものから元々入っていたものを引いて次のところに渡す記述

    tag_list.each do |tag|
      inspected_tag = Tag.where(tag_name: tag).first_or_create
      self.tags << inspected_tag
      #↑どういう動きか調べている最中
    end

  end

end