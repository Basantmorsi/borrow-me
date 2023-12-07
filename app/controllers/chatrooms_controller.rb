class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.includes(:messages).find(params[:id])
    @message = Message.new
  end
end
