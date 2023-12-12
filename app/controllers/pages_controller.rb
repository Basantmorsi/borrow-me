class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @tools = Tool.limit(6)
    @latest_requests = Request.all.last(5)
  end

  def testnave

  end
end
