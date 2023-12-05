class ToolsController < ApplicationController
  def index
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.user_id = current_user.id
    if @tool.save
      redirect_to tools_path, notice: 'Tool was successfully created.'
    else
      flash.now[:alert] = 'Failed to create a tool. Please fix the errors below.'
      render :new
    end
  end

  def edit
    @tool = Tool.find(params[:id])
  end

  def update
    @tool = Tool.find(params[:id])
    @tool.update(tool_params)
    redirect_to tools_path
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :description, :availability, :manual, :brand)
  end

end
