class DashboardController < ApplicationController
  def index
    @user = User.find(current_user.id)
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "dashboard/profile", locals: {user: @user}, formats: [:html] }
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
