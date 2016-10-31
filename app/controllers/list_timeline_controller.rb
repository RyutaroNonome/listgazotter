class ListTimelineController < ApplicationController
  def listtimeline
    #@clientを使えるようにする。
    @client = twitter_client
    #クリックされたされたリストの名前を文字データにして@tlに入れる。
    @tl = params[:name]
  end
end