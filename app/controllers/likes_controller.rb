class LikesController < ApplicationController
  # GET /likes
  # GET /likes.json
  def index
    @likes = Like.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @likes }
    end
  end

  # GET /likes/1
  # GET /likes/1.json
  def show
    @like = Like.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @like }
    end
  end

  # GET /likes/new
  # GET /likes/new.json
  def new
    @like = Like.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @like }
    end
  end

  # GET /likes/1/edit
  def edit
    @like = Like.find(params[:id])
  end

  # POST /likes
  # POST /likes.json
  def create
    @inspiration = Inspiration.find(params[:inspiration_id])

    unless current_user == @inspiration.user
      @like = Like.new(user: current_user, inspiration: @inspiration)
      @like.save
      #@inspiration.like = @inspiration.like + 1
      #@inspiration.save

      @inspiration.user.increment 3
    end

    respond_to do |format|
      format.js
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @inspiration = Inspiration.find(params[:inspiration_id])

    unless current_user == @inspiration.user
      @like = Like.where(user: current_user, inspiration: @inspiration).first
      @like.destroy

      @inspiration.user.decrement 3
    end

    respond_to do |format|
      format.js
    end
  end
end
