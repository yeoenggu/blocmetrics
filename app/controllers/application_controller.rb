class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  # protect_from_forgery with: :exception


  def self.cors_allowed_actions 
    @cors_allowed_actions ||= []
  end

  def self.cors_allowed_actions=(arr)
    @cors_allowed_actions = arr
  end

  def self.allow_cors(*methods)
    self.cors_allowed_actions += methods
    before_filter :cors_before_filter, :only => methods
    protect_from_forgery with: :null_session, :only => methods
  end

  # Overload handle_unverified_request to ensure that
  # exception is raised each time a request does not
  # pass validation.
  def handle_unverified_request
    raise(ActionController::InvalidAuthenticityToken)
  end

  def cors_before_filter
    if /\Ahttps?:\/\/localhost:3333\z/ =~ request.headers['Origin']
      headers['Access-Control-Allow-Origin'] = request.headers['Origin']
    end
  end
end
