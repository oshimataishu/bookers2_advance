class MessagesController < ApplicationController
  def show
    @user = User.find(params[:id])
    room_ids = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: room_ids)

    if user_rooms
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @messages = @room.messages
    @new_message = Message.new(room_id: @room.id)
  end

  def create
    @new_message = current_user.messages.new(message_params)
    @room = @new_message.room
    @messages = @room.messages
    render :validater unless @new_message.save
  end

  private
  def message_params
    params.require(:message).permit(:message, :room_id)
  end
end
