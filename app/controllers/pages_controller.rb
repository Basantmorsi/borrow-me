class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @tools = Tool.limit(6)
    @latest_requests = Request.all.last(5)
  end

  def testnave

  end

  def Edit
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "devise/registrations/edit", formats: [:html] }
    end
  end
end
