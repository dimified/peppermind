class LikesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @inspiration = Inspiration.find(params[:inspiration_id])

    unless current_user == @inspiration.user
      @like = Like.new(user: current_user, inspiration: @inspiration)
      @like.save
      @inspiration.add_like

      @inspiration.user.increment(points: 3)
      @inspiration.user.update_user_level
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
      @inspiration.user.decrement(points: 3)
      @inspiration.user.update_user_level
    end

    respond_to do |format|
      format.js
    end
  end
end
