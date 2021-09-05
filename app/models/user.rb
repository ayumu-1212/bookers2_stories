class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  
  has_many :owner_groups, class_name: "Group", foreign_key: "owner_id"
  
  attachment :profile_image

  validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}
  
  def join?(group)
    self.groups.include?(group) || group.owner_id == self.id
  end
end
