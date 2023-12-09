class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
    else
      render "chatrooms/show", status: :unprocessable_entity
    end
  end

  def  sendMessage
    # find the tool, we send message about
    @tool = Tool.find(params[:query])
    # find the user id, who sends the message
    @sender = current_user
    # find the recipient id, who owns the tool
    @recipient = User.find(@tool.user_id)
    # find if chatroom between sender and recipient already exits
    @chatroom = Chatroom.where(sender_id: [@sender.id , @recipient.id]).and(Chatroom.where(recipient_id: [@sender.id , @recipient.id])).first

    # @chatroom = Chatroom.where(sender_id: [@sender.id , @recipient.id], recipient_id: [@sender.id , @recipient.id]).first

    if !@chatroom.present?
      @chatroom = Chatroom.new
      @chatroom.name = "Private Chat between #{@sender.username} and #{@recipient.username}"
      @chatroom.sender = @sender
      @chatroom.recipient = @recipient
      @chatroom.save
    end

    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user

    if @message.save
      flash.now[:notice]  ='Message sent!'
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok

    else
      flash.now[:alert] = 'Failed to send the message'
      render :new
      # render "chatrooms/show", status: :unprocessable_entity
    end

  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
