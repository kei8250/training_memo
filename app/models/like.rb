class Like < ApplicationRecord
    validates :user_id, {presence: true}
    validates :workout_id, {presence: true}
end
