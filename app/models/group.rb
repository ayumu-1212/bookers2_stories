class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  
  belongs_to :owner, class_name: "User"
  attachment :image

  validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}
  
end
