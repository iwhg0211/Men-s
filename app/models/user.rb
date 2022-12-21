class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_one_attached :user_image
         has_many :posts
         has_many :reviews

  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now # ← Confirmable を設定している場合は追加
      # user.name = "ゲストユーザー" # ←ユーザー名を設定している場合は追加
    end
  end
  
end