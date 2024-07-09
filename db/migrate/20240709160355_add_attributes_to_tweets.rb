class AddAttributesToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :message, :string
    add_column :tweets, :user_id, :integer
    add_column :tweets, :timestamps, :datetime
  end
end
