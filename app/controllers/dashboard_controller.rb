class DashboardController < ApplicationController
  def index
    @user = User.find(current_user.id)
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "dashboard/profile", locals: {user: @user}, formats: [:html] }
    end
  end
end
