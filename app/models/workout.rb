class Workout < ApplicationRecord
    has_many :records, dependent: :destroy
    
    validates :name, presence: true
    validates :part, presence: true
    
end
