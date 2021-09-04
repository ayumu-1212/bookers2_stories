class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # follow機能
  has_many :follows, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy # フォロー取得
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロワー取得
  
  has_many :follow_users, through: :followers, source: :follow # 自分がフォローしている人
  has_many :follower_users, through: :follows, source: :follower # 自分をフォローしている人
  
  def followed_by?(user)
    self.follower_users.where(id: user.id).present?
  end
  
  # chat機能
  has_many :room_users, dependent: :destroy
  has_many :chat_rooms, through: :room_users
  has_many :chat_messages
  
  def chat_users
    user.chat_rooms.map{|chat_room| chat_room.users }.flatten.uniq
  end
  
  
  has_many :favorites, dependent: :destroy
  
  attachment :profile_image

  validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}
  

end
