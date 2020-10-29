class Record < ApplicationRecord
  belongs_to :workout
  validates :weight, presence: true
  validates :reps, presence: true
  validates :user_id, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end
end
