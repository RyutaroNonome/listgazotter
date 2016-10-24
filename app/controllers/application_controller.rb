class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def twitter_client
    if au = AuthUser.find_by_id(session[:auth_user_id])
      client = Twitter::REST::Client.new do |config|
        config.consumer_key    = 'yZtf6PURnd0G9e67WbE9z3ZMb'
        config.consumer_secret = '1A1a8R2dW3x8ZObccqzi7eDwlUtbpQuYxX2rkwDQxYDVdadPmf'
        config.access_token    = au.token
        config.access_token_secret = au.secret
      end
    end
  end
end