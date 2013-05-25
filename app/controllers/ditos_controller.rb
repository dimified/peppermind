class DitosController < ApplicationController
  before_filter :authenticate_user!

  def create
    @challenge = Challenge.find(params[:challenge_id])

    unless current_user == @challenge.user
      @dito = Dito.new(user: current_user, challenge: @challenge)
      @dito.save

      @challenge.user.increment
      @challenge.user.update_user_level
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @challenge = Challenge.find(params[:challenge_id])

    unless current_user == @challenge.user
      @dito = Dito.where(user: current_user, challenge: @challenge).first
      @dito.destroy

      @challenge.user.decrement
      @challenge.user.update_user_level
    end

    respond_to do |format|
      format.js
    end
  end
end

