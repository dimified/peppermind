class TagsController < ApplicationController
  def index
    # config and initialization
    min_percent = 100
    max_percent = 250
    min = max = 1

    # load tags
    tags = Challenge.tags_with_weight

    # set minimum and maximum count for tag
    tags.each do |tag|
      count = tag[1].to_i
      min = min > count ? count : min
      max = count > max ? count : max
    end

    # prevent division by zero
    max += 1 if min === max

    # calculate offset
    multiplier = (max_percent - min_percent) / (max - min)
    offset = min_percent - min * multiplier
    @tags = []

    # calculate font size and assign tags to view
    tags.each do |tag|
      size = tag[1].to_i * multiplier + offset
      @tags.push([tag[0], size.to_s])
    end
  end

  def show
    @tag = URI::unescape(params[:id])
    @challenges = Challenge.tagged_with(@tag).page params[:page]
  end
end
