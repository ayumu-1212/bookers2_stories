class ChatsController < ApplicationController
  def show
    @chat_room = ChatRoom.find(params[:id])
    @new_chat_message = ChatMessage.new
    @chat_messages = ChatMessage.where(chat_room_id: @chat_room.id)
    @opponent = @chat_room.users.where.not(id: current_user.id).first
  end
  
  def create
    opponent = User.find(params[:opponent_id])
    overlapped_chat_room = (opponent.chat_rooms & current_user.chat_rooms).first
    if overlapped_chat_room.present?
      redirect_to chat_path(overlapped_chat_room.id)
    else
      chat_room = ChatRoom.create()
      RoomUser.create(chat_room_id: chat_room.id, user_id: current_user.id)
      RoomUser.create(chat_room_id: chat_room.id, user_id: opponent.id)
      redirect_to chat_path(chat_room.id)
    end
  end
  
  def create_message
    @new_chat_message = ChatMessage.new(chat_message_params)
    @new_chat_message.user_id = current_user.id
    @new_chat_message.chat_room_id = params[:chat_room_id]
    if @new_chat_message.save
      @chat_messages = ChatMessage.all
    else
      @chat_room = ChatRoom.find(@new_chat_message.chat_room_id)
      flash[:notice] = "送信に失敗しました。文字数を確認して再度送信しましょう。"
      render :show
    end
  end
  
  private
  def chat_message_params
    params.require(:chat_message).permit(:body)
  end
end
