class DitosController < ApplicationController
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

      @user = @challenge.user
      @user.increment 1
    end
    
    respond_to do |format|
      format.js
    end
  end

  def update
    @dito = Dito.find(params[:id])

    respond_to do |format|
      if @dito.update_attributes(params[:dito])
        format.html { redirect_to @dito }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dito.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @challenge = Challenge.find(params[:challenge_id])
  
    unless current_user == @challenge.user
      @dito = current_user.ditos.where(challenge: @challenge).first
      @dito.destroy

      @user = @challenge.user
      @user.decrement 1
    end

    respond_to do |format|
      format.js
    end
  end
end
