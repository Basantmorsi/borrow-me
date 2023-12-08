class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @tools = Tool.limit(50)
    @latest_requests = Request.all.last(5)
  end
end
