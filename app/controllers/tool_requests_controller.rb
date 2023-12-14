class ToolRequestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tool_request = ToolRequest.new
  end

  def index
    # Retrieve tools owned by the current user
    user_tools = current_user.tools

    # Retrieve tool requests for the user's tools
    @tool_requests = ToolRequest.where(tool_id: user_tools, approved: false)

    # You may want to include additional conditions or sorting based on your requirements
    # For example, you can order the requests by creation time:
    @tool_requests = @tool_requests.order(created_at: :desc)

    respond_to do |format|
      format.html do
        render partial: "tool_requests/index", locals: { tool_requests: @tool_requests }, formats: [:html], layout: false
      end# Follow the regular flow of Rails

      # Respond to text format with a partial
      format.text do
        render partial: "tool_requests/index", locals: { tool_requests: @tool_requests }, formats: [:html]
      end
    end
  end

  # In your ToolRequestsController
  def tool_request_params
    params.require(:tool_request).permit(:user_id, :tool_id, :start_date, :end_date)
  end

  def create
    @tool_request = ToolRequest.new(tool_request_params)
    @tool_request.user = current_user
    @tool_request.tool = Tool.find(params[:tool_id])

    if @tool_request.save
      redirect_to tool_path(params[:tool_id]), notice: 'Tool request was successfully created.'
    elsif @tool_request.errors.any?
      redirect_to tool_path(params[:tool_id]), notice: 'Please make sure you select both dates, end date can not be before start date.'
    else
      redirect_to tool_path(params[:tool_id]), notice: 'There was a problem with creating your request'
    end
  end

  def approve

    @tool_request = ToolRequest.find(params[:id])
    @tool_request.update(approved: true)


    #send chat message after request approve
    @tool_id = nil

    @tool =Tool.find(@tool_request.tool_id)


    # find the user id, who sends the message
    @sender = current_user

    # find the recipient id, who owns the tool
    if @tool.present?
      @recipient = User.find(@tool_request.user_id)
      @tool_id = @tool.id
    end
    # find if chatroom between sender and recipient already exits
       @chatroom = Chatroom.where(sender_id: @sender.id , recipient_id: @recipient.id).and(Chatroom.where(recipient_id: @sender.id, sender_id: @recipient.id)).first

    if !@chatroom.present?
      @chatroom = Chatroom.new
      @chatroom.name = "Private Chat between #{@sender.username} and #{@recipient.username}"
      @chatroom.sender = @sender
      @chatroom.recipient = @recipient
      @chatroom.save
    end

    @message = Message.new()
    @message.content ="Hallo #{@recipient.username}, happy to help you! The #{@tool.name} is avaliable for you pick."
    @message.chatroom = @chatroom
    @message.user = current_user
    @message.tool_id = @tool_id
    @message.save
    # if
    #   flash.now[:notice]  ='Message sent!'
    #   # ChatroomChannel.broadcast_to(
    #   #   @chatroom,
    #   #   render_to_string(partial: "messages/message",formats: [:html, :js, :json, :url_encoded_form],
    #   #   locale: [:en],
    #   #   handlers: [:erb, :builder, :raw, :ruby, :coffee, :jbuilder], locals: {message: @message})
    #   # )
    #   head :ok

    # else
    #   flash.now[:alert] = 'Failed to send the message'
    #   head :bad_request
    # end
    respond_to do |format|
      format.json { render json: { message: 'Request approved successfully' } }
    end
  end
end
