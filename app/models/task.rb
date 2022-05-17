class Task < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 20 }
  validates :note, presence: true, length: { minimum: 5 }
end
