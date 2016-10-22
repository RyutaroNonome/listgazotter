# -*- coding: utf-8 -*-
class AuthUser < ActiveRecord::Base
  # attr_accessible :name, :provider, :uid, :credentials, :user_info_raw
  # rails3の書き方

  # privateをつけるかつけないか
  def auth_user_params
    params.require(:auth_user).permit(:name, :provider, :uid, :credentials, :user_info_raw)
  end

  # :credentials カラムの token と key を分わけるための分割記号
  CRED_SPLIT = '|%|'

  ##################################
  # Accessrors
  ##################################
  def user_info
    @user_info ||= eval(user_info_raw)
  end

  def token
    credentials.split(CRED_SPLIT)[0]
  end
  def secret
    credentials.split(CRED_SPLIT)[1]
  end
  def screen_name
    prefix = (provider == "twitter") ? "@" : ""
    prefix + user_info["name"]
  end
  def nickname
    user_info["nickname"]
  end
  def img_url
    user_info["image"]
  end

  ##################################
  # Find/Create/Update
  ##################################

  def self.find_or_create_with_omniauth auth
    au = AuthUser.find_by_provider_and_uid auth["provider"], auth["uid"]
    if au
      au.update_with_omniauth auth
    else
      au = AuthUser.create_with_omniauth auth
    end
    au
  end

  def self.create_with_omniauth auth
    create! do |a_user|
      a_user.provider = auth["provider"]
      a_user.uid      = auth["uid"]
      a_user.update_with_omniauth auth
    end
  end

  def update_with_omniauth auth
    a_user = self
    a_user.name           = auth["info"]["name"]
    a_user.credentials    =
      auth['credentials']['token'] + CRED_SPLIT + auth['credentials']['secret']
    a_user.user_info_raw  = auth["info"].to_hash.inspect
    a_user.save!
    self
  end

end