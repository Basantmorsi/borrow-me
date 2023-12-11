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
    @tool_id = nil
    @request = nil
    @request_id = nil
    # find the tool, we send message about
    @tool = Tool.find(params[:query])
    # find the user id, who sends the message
    @sender = current_user
    # find the recipient id, who owns the tool
    if @tool.present?
      @recipient = User.find(@tool.user_id)
      @tool_id = @tool.id
    else
      @request = Request.find(params[:query])
      @recipient = User.find(@request.user_id)
      @request_id = @request.id
    end
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
    @message.tool_id = @tool_id
    @message.request_id = @request_id

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
