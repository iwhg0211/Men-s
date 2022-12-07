class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_one_attached :user_image
         has_many :posts

 def active_for_authentication?
   super && (is_deleted == false)
   # ここのsuperと && の意味をまだよくわかっていません
 end

end