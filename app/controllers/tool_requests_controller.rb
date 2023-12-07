class ToolRequestsController < ApplicationController
  def new
    @tool_request = ToolRequest.new
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
    else
      redirect_to tool_path(params[:tool_id]), notice: "There was a problem with creating your request"
    end
  end
end
