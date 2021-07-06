class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image, destroy: false
  
  has_many :followeds,
   class_name: 'Relationship',
   foreign_key: 'followed_id',
   dependent: :destroy
  has_many :followers,
   class_name: 'Relationship',
   foreign_key: 'follower_id',
   dependent: :destroy
  has_many :follower_users, through: :followeds, source: :follower
  has_many :followed_users, through: :followers, source: :followed
  def follow(other_user_id)
    self.followers.create(followed_id: other_user_id)
  end
  def follower?(other_user)
    followed_users.include?(other_user)
  end
  
  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50 }
end
