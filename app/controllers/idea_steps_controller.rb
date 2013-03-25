class IdeaStepsController < ApplicationController
	include Wicked::Wizard
	steps :problem, :solution

	def show
		@idea = Idea.find(session[:idea_id])
		render_wizard
	end

	def update
		@idea = Idea.find(session[:idea_id])
		@idea.attributes = params[:idea]
		render_wizard @idea
	end

  private
  
  def finish_wizard_path
  	idea_path @idea
  end
end
