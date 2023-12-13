class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.includes(:messages).find(params[:id])
    @message = Message.new
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "chatrooms/show", locals: {chatroom: @chatroom}, formats: [:html] }
    end
  end

  def index
    @chatrooms = Chatroom.where(sender_id: current_user.id).or(Chatroom.where(recipient_id: current_user.id))
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "chatrooms/index", locals: {chatrooms: @chatrooms}, formats: [:html] }
    end
  end
end
