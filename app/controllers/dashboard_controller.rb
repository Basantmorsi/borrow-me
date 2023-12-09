class DashboardController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @user_tools = current_user.tools
    @tool_requests = ToolRequest.where(tool_id: @user_tools, approved: false)
    # You may want to include additional conditions or sorting based on your requirements
    # For example, you can order the requests by creation time:
    @tool_requests = @tool_requests.order(created_at: :desc)
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
  #   params.require(:user).permit(:email, )
  # end
end
