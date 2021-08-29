class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  
  has_many :follows, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy # フォロー取得
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロワー取得
  
  has_many :follow_users, through: :followers, source: :follow # 自分がフォローしている人
  has_many :follower_users, through: :follows, source: :follower # 自分をフォローしている人
  
  
  attachment :profile_image

  validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}
  
  def followed_by?(user)
    self.follower_users.where(id: user.id).present?
  end
end
