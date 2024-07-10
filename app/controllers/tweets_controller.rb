class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.order(created_at: :desc)
    render 'tweets/index'
  end

  def index_by_user
    # TODO: remove this
    token = cookies.permanent.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    # TODO: find user by username, not by current user

    if session
      @tweets = session.user.tweets
      render 'tweets/index'
    else
      render json: { tweets: [] }
    end
  end

  def create
    token = cookies.permanent.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user
      @tweet = user.tweets.new(tweet_params)

      if @tweet.save
        render 'tweets/create'
      else
        render json: { success: false }
      end
    else
      render json: { success: false }
    end
  end

  def destroy
    # TODO: get current user and check if the user is the owner of the tweet

    @tweet = Tweet.find_by(id: params[:id])
    if @tweet&.destroy
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:message)
  end
end
