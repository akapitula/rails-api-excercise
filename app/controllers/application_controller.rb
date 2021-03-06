class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :null_session

  # - Methods
  # Public: structure the response for a successful request to create a resource.
  # 
  # opts - a Hash contaning any extra information to send along with the response  
  # 
  # Returns a HTTP response with status 201.
  def render_created(opts = {})
    render json: opts, root: false, status: :created
  end

  # Public: structure the response for a failed request to create a resource.
  # 
  # model - the Object attempted to create
  # opts - a Hash contaning any extra information to send along with the response
  # 
  # Returns a HTTP response with status 422.
  def render_unprocessable(model, opts = {})
    render json: opts.merge(errors: model.errors), status: :unprocessable_entity
  end

  def render_not_found
    head :not_found
  end
end
