get '/send_tweets' do
  erb :send_tweets
end

get '/' do
  erb :index
end

get '/:username' do
  if @user = User.find_by_username(params[:username])
    if Time.now - @user.tweets.first.created_at > 900
      @user.tweets.destroy_all
      @tweets = Tweet.tweet_getter(@user)
    else
      @tweets = @user.tweets
    end
  else
    @user = User.create(username: params[:username])
    @tweets = Tweet.tweet_getter(@user)
  end
  erb :tweets
end

#===========POST==============#

post '/tweets' do 
  redirect to("/#{params[:username]}")
end

post '/send_tweets' do
  Tweet.send_tweet(params[:text])
  redirect '/'
end



