class TweetsController < ApplicationController
    def index
        @tweets = Tweet.all.order(created_at: :desc)
        render 'tweets/index'
    end

    def index_by_user
        search = User.find_by(username: params[:username])

        if search
            @tweets = search.tweets
            render 'tweets/index_by_user'
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
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)
        @tweet = Tweet.find_by(id: params[:id])

        if session and @tweet&.destroy
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
