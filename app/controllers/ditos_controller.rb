class DitosController < ApplicationController
  # GET /ditos
  # GET /ditos.json
  def index
    @ditos = Dito.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ditos }
    end
  end

  # GET /ditos/1
  # GET /ditos/1.json
  def show
    @dito = Dito.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dito }
    end
  end

  # GET /ditos/new
  # GET /ditos/new.json
  def new
    @dito = Dito.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dito }
    end
  end

  # GET /ditos/1/edit
  def edit
    @dito = Dito.find(params[:id])
  end

  # POST /ditos
  # POST /ditos.json
  def create
    @challenge = Challenge.find(session[:challenge_id])
    @dito = Dito.new(params[:dito])
    @dito.challenge = @challenge
    @dito.user = current_user

    respond_to do |format|
      if @dito.save
        format.html { redirect_to @dito, notice: 'Dito was successfully created.' }
        format.json { render json: @dito, status: :created, location: @dito }
      else
        format.html { render action: "new" }
        format.json { render json: @dito.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ditos/1
  # PUT /ditos/1.json
  def update
    @dito = Dito.find(params[:id])

    respond_to do |format|
      if @dito.update_attributes(params[:dito])
        format.html { redirect_to @dito, notice: 'Dito was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dito.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ditos/1
  # DELETE /ditos/1.json
  def destroy
    @dito = Dito.find(params[:id])
    @dito.destroy

    respond_to do |format|
      format.html { redirect_to ditos_url }
      format.json { head :no_content }
    end
  end
end
