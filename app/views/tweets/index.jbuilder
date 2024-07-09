json.tweet do
    json.array! @tweets do |tweet|
        json.message         tweet.message
        json.user_id    tweet.user_id
        json.timestamps  tweet.timestamps
    end
end