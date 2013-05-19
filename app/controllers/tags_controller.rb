class TagsController < ApplicationController
  def index
    @tags = Challenge.tags_with_weight
  end

  def show
    @tag = URI::unescape(params[:id])
    @challenges = Challenge.tagged_with(@tag).page params[:page]
  end
end
