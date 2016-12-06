class ListTimelineController < ApplicationController
  def listtimeline
    #@clientを使えるようにする。
    @client = twitter_client
    #クリックされたされたリスト名を文字データにして@tlに入れる。
    begin
      @lists = @client.lists
    rescue Twitter::Error::TooManyRequests
      redirect_to error_page_path
    end
    @tl_id = params[:id].to_i
    @tl_name = params[:name]
    #画像付きツイートだけ格納
    @tweets = @client.list_timeline(@tl_id,count: 200)
     # :include_entities => trueを付けなくても動く。
     # @tweets = @client.list_timeline(@tl,count: 200,:include_entities => true)

     #https?~,RT,判別後格納。
    @tweets_with_image = pick_tweets_with_image
  end

  def mypage
    @client = twitter_client
    begin
      @lists = @client.lists
    rescue Twitter::Error::TooManyRequests
      redirect_to error_page_path
    end
  end

  def error_page
  end

  private

  def pick_tweets_with_image
    # @tweet_array = []
    max_id = @client.list_timeline(@tl_id).first.id
    selected_tweets = []
    6.times do
    # 4.times.map do
      tweets = @client.list_timeline(@tl_id, max_id: max_id, count: 200)
      if (tweets.is_a?(Array))
        temp_tweets = tweets.select do |tweet|
          # http~含み且つRT含まない。
          !!(tweet.text =~ /https?:\/\/t\.co\/\w{10}/) && !(tweet.text =~ /RT/) && !(tweet.text =~ /shindanmaker/)
          # @tweet_array << tweet
        end
        selected_tweets.concat(temp_tweets)
      # else
        # []
      end #if
      max_id = selected_tweets.last.id - 1
      # sleep 60
    end #times
    selected_tweets
  end #def
end