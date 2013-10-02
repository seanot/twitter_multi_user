get '/send_tweets' do
  @user = current_user
  erb :send_tweets
end

get '/' do
  @user = current_user
  erb :index
end

get '/:username' do
  if @user = User.find_by_username(params[:username])
    
    if @user.tweets && Time.now - @user.tweets.first.created_at > 900
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

post '/user/:id/send_tweets' do
  Tweet.send_tweet(params[:text], current_user)
  redirect '/'
end



