class LikesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @likes = Like.all

    respond_to do |format|
      format.html
      format.json { render json: @likes }
    end
  end

  def show
    @like = Like.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @like }
    end
  end

  def new
    @like = Like.new

    respond_to do |format|
      format.html
      format.json { render json: @like }
    end
  end

  def edit
    @like = Like.find(params[:id])
  end

  def create
    @inspiration = Inspiration.find(params[:inspiration_id])

    unless current_user == @inspiration.user
      @like = Like.new(user: current_user, inspiration: @inspiration)
      @like.save
      @inspiration.add_like
      @inspiration.user.increment 3
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @inspiration = Inspiration.find(params[:inspiration_id])

    unless current_user == @inspiration.user
      @like = Like.where(user: current_user, inspiration: @inspiration).first
      @like.destroy
      @inspiration.remove_like
      @inspiration.user.decrement 3
    end

    respond_to do |format|
      format.js
    end
  end
end
