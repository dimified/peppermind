class DitosController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @ditos = Dito.all

    respond_to do |format|
      format.html
      format.json { render json: @ditos }
    end
  end

  def show
    @dito = Dito.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @dito }
    end
  end

  def new
    @dito = Dito.new

    respond_to do |format|
      format.html
      format.json { render json: @dito }
    end
  end

  def edit
    @dito = Dito.find(params[:id])
  end

  def create
    @challenge = Challenge.find(params[:challenge_id])
    
    unless current_user == @challenge.user
      @dito = Dito.new(user: current_user, challenge: @challenge)
      @dito.save

      @challenge.user.increment 1
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

      @challenge.user.decrement 1
    end

    respond_to do |format|
      format.js
    end
  end
end
