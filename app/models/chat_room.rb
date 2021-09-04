class ChatRoom < ApplicationRecord
  # chat機能
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users
  has_many :chat_messages, dependent: :destroy
end
