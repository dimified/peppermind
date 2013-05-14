class IdeaStepsController < ApplicationController
	include Wicked::Wizard
	steps :problem, :solution

	def show
		@challenge = Challenge.find(session[:challenge_id])
		render_wizard
	end

	def update
		@challenge = Challenge.find(session[:challenge_id])
		@challenge.attributes = params[:challenge]
		render_wizard @challenge
	end

  private
  
  def finish_wizard_path
  	challenge_path @challenge
  end
end
