class Tweet < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user



  def self.tweet_getter(user)
    tweets = Twitter.user_timeline(user.username, count: 10,
                                            include_rts: false)
    tweets_array = []
    
    tweets.each do |tweet|
      tweets_array << Tweet.create(user_id: user.id,
                                      text: tweet.text,
                                created_at: Time.now)
    end
    tweets_array
  end

  def self.send_tweet(status, current_user)
    twitter_user = Twitter::Client.new(oauth_token: current_user.oauth_token,
                                oauth_token_secret: current_user.oauth_secret)
    twitter_user.update(status)
  end

end
