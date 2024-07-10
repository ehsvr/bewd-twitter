class Session < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true

  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.uuid
  end
end
