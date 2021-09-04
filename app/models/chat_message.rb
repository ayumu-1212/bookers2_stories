class ChatMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  validates :body, length: { minimum: 1, maximum: 140 }
end
