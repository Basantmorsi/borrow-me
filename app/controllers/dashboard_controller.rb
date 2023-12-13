class DashboardController < ApplicationController

  def index
    @user = User.find(current_user.id)
    @user_tools = current_user.tools
    @tool_requests = ToolRequest.where(tool_id: @user_tools, approved: false)
    # You may want to include additional conditions or sorting based on your requirements
    # For example, you can order the requests by creation time:
    @tool_requests = @tool_requests.order(created_at: :desc)

    #Select Chatroom for the user
    @chats_users = []
    @chatrooms = Chatroom.where(sender_id: current_user.id).
    or(Chatroom.where(recipient_id: current_user.id))
    # .joins("INNER JOIN users ON users.id = chatrooms.sender_id OR users.id = chatrooms.recipient_id")
    if @chatrooms.present?
      @chatrooms.each do |chatroom|
        if chatroom.sender_id === current_user.id

          #[#<User id: 2, email: "jan@jan.com", created_at: "2023-12-07 14:02:48.346178000 +0000",
          # updated_at: "2023-12-07 14:02:48.346178000 +0000", username: "jan.doe",
          # address: "dresden germany", about_me: nil, latitude: 51.0493286, longitude: 13.7381437>
          # user = User.find(chatroom.recipient_id)
          # @chats_users << {}
          @chats_users << User.find(chatroom.recipient_id)
        else
          @chats_users << User.find(chatroom.sender_id)
        end
      end
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "tool_requests/index", locals: {tool_requests: @tool_requests}, formats: [:html] }
    end
  end

  def profile
    @user = current_user
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "dashboard/profile", locals: {user: @user}, formats: [:html] }
    end
  end

  def mytools
    @user = current_user
    @user_tools = current_user.tools
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "dashboard/mytools", locals: {user: @user}, formats: [:html] }
    end
  end

  def show
    @user = current_user
    @user_tools = current_user.tools
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "dashboard/mytools", locals: {user: @user}, formats: [:html] }
    end
  end


  def edit
    @user = User.find(current_user.id)
  end


  # def update
  #   @user = User.find(current_user.id)
  #   @user.update(tool_params)
  #   redirect_to tools_path
  # end

  # private

  # def user_params
  #   params.require(:user).permit(:photo)
  # end
end
