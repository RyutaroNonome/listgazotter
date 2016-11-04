class ListTimelineController < ApplicationController
  def listtimeline
    #@clientを使えるようにする。
    @client = twitter_client
    @tl = params[:name]
    #クリックされたされたリストの名前を文字データにして@tlに入れる。
    @tweets = @client.list_timeline(@tl,count: 800,:include_entities => true)
    @tweets_with_image = pick_tweets_with_image
  end

  private

  def pick_tweets_with_image
    if (@tweets.is_a?(Array))
      @tweets.select do |tweet|
        !!(tweet.text =~ /https?:\/\/t\.co\/\w{10}/) && !(tweet.text =~ /RT/)
      end
    else
      []
    end
  end
end