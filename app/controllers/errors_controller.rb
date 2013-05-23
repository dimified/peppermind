class ErrorsController < ApplicationController
  def render_404
    respond_to do |format|
      format.html { render template: 'errors/error_404', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end
end
