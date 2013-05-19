class InspirationsController < ApplicationController
  def index
    @inspirations = Inspiration.all

    respond_to do |format|
      format.html
      format.json { render json: @inspirations }
    end
  end

  def show
    @challenge = Challenge.find(params[:challenge_id])
    @inspiration = @challenge.inspirations.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @inspiration }
    end
  end

  def new
    @challenge = Challenge.find(params[:challenge_id])
    @inspiration = @challenge.inspirations.build

    respond_to do |format|
      format.html
      format.json { render json: @inspiration }
    end
  end

  def edit
    @inspiration = Inspiration.find(params[:id])
  end

  def create
    @challenge = Challenge.find(params[:challenge_id])
    @inspiration = @challenge.inspirations.new(params[:inspiration])

    respond_to do |format|
      if @inspiration.save
        format.html { redirect_to challenge_inspiration_path(@challenge, @inspiration), notice: I18n.t('challenge_inspirations.created') }
        format.json { render json: challenge_inspiration_path(@challenge, @inspiration), status: :created, location: @inspiration }
      else
        format.html { render action: 'new' }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @inspiration = Inspiration.find(params[:id])

    respond_to do |format|
      if @inspiration.update_attributes(params[:inspiration])
        format.html { redirect_to @inspiration, notice: I18n.t('challenge_inspirations.updated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inspiration = Inspiration.find(params[:id])
    @inspiration.destroy

    respond_to do |format|
      format.html { redirect_to inspirations_url }
      format.json { head :no_content }
    end
  end
end
