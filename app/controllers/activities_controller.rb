class ActivitiesController < ApplicationController
  def index
    @activities = Activity.order_by([:id, :desc]).page params[:page]

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @activities }
    end
  end
end
