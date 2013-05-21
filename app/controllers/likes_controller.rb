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

      user = @inspiration.user
      user.points = user.points + 3
      user.save(validate: false)

      respond_to do |format|
        if @like.save
          format.js
        end
      end
    end
  end

  # PUT /likes/1
  # PUT /likes/1.json
  def update
    @like = Like.find(params[:id])

    respond_to do |format|
      if @like.update_attributes(params[:like])
        format.html { redirect_to @like, notice: 'Like was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @inspiration = Inspiration.find(params[:inspiration_id])

    unless current_user == @inspiration.user
      @like = current_user.likes.where(inspiration: @inspiration).first
      @like.destroy

      user = @inspiration.user
      user.points = user.points - 3
      user.save(validate: false)

      respond_to do |format|
        format.js
      end
    end
  end
end
