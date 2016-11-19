# -*- encoding: utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def twitter_client
    if au = AuthUser.find_by_id(session[:auth_user_id])
      client = Twitter::REST::Client.new do |config|
        config.consumer_key    = Settings.twitter[:consumer_key]
        config.consumer_secret = Settings.twitter[:consumer_secret]
        config.access_token    = au.token
        config.access_token_secret = au.secret
      end
    end
  end
end