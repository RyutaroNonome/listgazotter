class ListTimelineController < ApplicationController
  def listtimeline
    @tl = params[:name]
    @client = twitter_client
  end
end