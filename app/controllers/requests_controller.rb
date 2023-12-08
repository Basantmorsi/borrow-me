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

  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    #respond_to do |format|
      #format.html { redirect_to requests_url, notice: 'Request was successfully deleted.' }
      #format.json { head :no_content }
    #end
    redirect_to root_path, status: :see_other
  end

  private

  def request_params
    params.require(:request).permit(:message)
  end
end
