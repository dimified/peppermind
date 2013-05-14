class IdeasController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  def index
    @ideas = Idea.order_by([:created_at, :desc]).page params[:page]

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @ideas }
    end
  end

  def show
    @idea = Idea.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @idea }
    end
  end

  def new
    @idea = Idea.new

    respond_to do |format|
      format.html
      format.json { render json: @idea }
    end
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def create
    @idea = current_user.ideas.build(params[:idea])

    respond_to do |format|
      if @idea.save
        track_activity @idea
        session[:idea_id] = @idea.id
        format.html { redirect_to @idea }
        format.json { render json: @idea }
      else
        format.html { render action: 'new' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @idea = Idea.find(params[:id])

    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        track_activity @idea
        format.html { redirect_to @idea }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to ideas_url }
      format.json { head :no_content }
    end
  end
end
