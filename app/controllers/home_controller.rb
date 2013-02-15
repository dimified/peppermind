class HomeController < ApplicationController
  # GET /home
  # GET /home.json
  def index
    @home = Home.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @home }
    end
  end
end
