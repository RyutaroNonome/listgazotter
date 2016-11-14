class ListTimelineController < ApplicationController
  def listtimeline
    #@clientを使えるようにする。
    @client = twitter_client
    #クリックされたされたリスト名を文字データにして@tlに入れる。
    @tl = params[:name]
    #画像付きツイートだけ格納
    @tweets = @client.list_timeline(@tl,count: 200)
     # :include_entities => trueを付けなくても動く。
     # @tweets = @client.list_timeline(@tl,count: 200,:include_entities => true)

     #https?~,RT,判別後格納。
     @tweets_with_image = pick_tweets_with_image
  end

  private

  def pick_tweets_with_image
    if (@tweets.is_a?(Array))
      @tweets.select do |tweet|
        # http~含み且つRT含まない。
        !!(tweet.text =~ /https?:\/\/t\.co\/\w{10}/) && !(tweet.text =~ /RT/)
      end
    else
      []
    end
  end
end