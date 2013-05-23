class TagsController < ApplicationController
  def index
    tags = Challenge.tags_with_weight
    @tags = []

    tags.each do |tag|
      size =  tag[1] / 10 + 1
      size = 1 if size < 1
      size = 2 if size > 2
      @tags.push([tag[0], size.to_s])
    end
  end

  def show
    @tag = URI::unescape(params[:id])
    @challenges = Challenge.tagged_with(@tag).page params[:page]
  end
end
