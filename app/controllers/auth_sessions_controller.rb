class AuthSessionsController < ApplicationController

  # redirect to provider's authorizing page.
  def auth
    consumer_key = 'yZtf6PURnd0G9e67WbE9z3ZMb'
    url = case params[:provider]
          when "twitter"
            "https://api.twitter.com/oauth/authorize?oauth_token=" + consumer_key      #def auth に consumer key をベタ書きしているが、実際はグローバル参照可能なクラスに定数として定義しておく
          else
            raise "Unknown provider error."
          end
    redirect_to url # Twitter 公式の認証ページへ飛ぶ
  end

  # /auth/:provider/callback
  def create
    auth = request.env["omniauth.auth"]
    auth_user = AuthUser.find_or_create_with_omniauth auth
    session[:auth_user_id] = auth_user.id
    redirect_to '/' # とりあえずトップページに移動
  end

  # /auth/signout
  def signout
    session[:auth_user_id] = nil
    # redirect_to '/', :notice => "認証を外しました。"
    render :text => "認証を外しました。" # とりあえず
  end

end