class RequestsController < ApplicationController
  def index
    @request = Request.all
  end

  def post_request
    @request = Request.new(request_params)
    @request.user = current_user
    if @request.save
      redirect_to root_path, notice: 'Request submitted successfully!'
    else
      render :post_request
    end
  end

  private

  def request_params
    params.require(:request).permit(:message)
  end
end
