class ToolsController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests = Request.all
    @tools = Tool.all
    @tools = @tools.search_by_name(params[:search]) if params[:search].present?

    if params[:search].present?
      @available_tools = @tools.where(availability: true).limit(9)
      @user = current_user
      @markers = @available_tools.map do |tool|
        {
          lng: tool.user.longitude,
          lat: tool.user.latitude,
          info_window_html: render_to_string(partial: "info_window", locals: { user: @user })
        }
      end
    end
    respond_to do |format|
      format.html
      format.text { render partial: "tools/list", locals: { tools: @tools }, formats: [:html] }
    end
  end

  def show
    @tool = Tool.find(params[:id])

    @tool_request = ToolRequest.new

    @user = @tool.user



    # select chatroom if exists for sender and reciever
    # @chatroom = Chatroom.where(sender_id: current_user.id, recipient_id: @user.id )
    # if !@chatroom
    #   @chatroom = Chatroom.new
    # end



    @markers = [{
      lng: @user.longitude,
      lat: @user.latitude,
      info_window_html: render_to_string(partial: "info_window", locals: { user: @user })
    }]


  end

  def new
    @tool = Tool.new
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "tools/form", locals: {tool: @tool}, formats: [:html] }
    end
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
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "tools/form", locals: {tool: @tool}, formats: [:html] }
    end
  end

  def update
    @tool = Tool.find(params[:id])

    if @tool.update(tool_params)
      render json: { success: true, message: 'Tool updated successfully' }
    else
      render json: { success: false, errors: @tool.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @tool = Tool.find(params[:id])
    @tool.destroy
    redirect_to tools_path, status: :see_other
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :description, :availability, :manual, :photo, :brand)
  end
end
