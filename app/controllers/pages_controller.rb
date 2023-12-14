class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @tools = Tool.all.last(6)
    @latest_requests = Request.all.last(3)
  end

  def testnave

  end

  def edit
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "devise/registrations/edit", formats: [:html] }
    end
  end
end
