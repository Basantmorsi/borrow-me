class ToolRequestsController < ApplicationController
  def index
    @tool_requests = ToolRequest.joins(:tools).where({ tools: { user_id: current_user.id } })
  end

  def new
    @tool = ToolRequest.new
  end

  def create
    # Assuming you receive these parameters from a form submission
    tool_request_params = params.require(:tool_request).permit(:user_id, :tool_id, :start_date, :end_date)

    # Create a new ToolRequest with the received parameters
    @tool_request = ToolRequest.new(tool_request_params)

    # You might want to set other attributes, e.g., approved, based on your requirements

    # Save the new ToolRequest to the database
    if @tool_request.save
      redirect_to tool_requests_path, notice: 'Tool request was successfully created.'
    else
      render :new
    end
  end
end
