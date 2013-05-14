class InspirationsController < ApplicationController
  # GET /inspirations
  # GET /inspirations.json
  def index
    @inspirations = Inspiration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inspirations }
    end
  end

  # GET /inspirations/1
  # GET /inspirations/1.json
  def show
    @idea = Idea.find(params[:idea_id])
    @inspiration = @idea.inspirations.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inspiration }
    end
  end

  # GET /inspirations/new
  # GET /inspirations/new.json
  def new
    @idea = Idea.find(params[:idea_id])
    @inspiration = @idea.inspirations.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inspiration }
    end
  end

  # GET /inspirations/1/edit
  def edit
    @inspiration = Inspiration.find(params[:id])
  end

  # POST /inspirations
  # POST /inspirations.json
  def create
    @idea = Idea.find(params[:idea_id])
    @inspiration = @idea.inspirations.new(params[:inspiration])

    respond_to do |format|
      if @inspiration.save
        format.html { redirect_to idea_inspiration_path(@idea, @inspiration), notice: 'Inspiration was successfully created.' }
        format.json { render json: idea_inspiration_path(@idea, @inspiration), status: :created, location: @inspiration }
      else
        format.html { render action: "new" }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inspirations/1
  # PUT /inspirations/1.json
  def update
    @inspiration = Inspiration.find(params[:id])

    respond_to do |format|
      if @inspiration.update_attributes(params[:inspiration])
        format.html { redirect_to @inspiration, notice: 'Inspiration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspirations/1
  # DELETE /inspirations/1.json
  def destroy
    @inspiration = Inspiration.find(params[:id])
    @inspiration.destroy

    respond_to do |format|
      format.html { redirect_to inspirations_url }
      format.json { head :no_content }
    end
  end
end
