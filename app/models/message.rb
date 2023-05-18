class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message, length: { minimum: 1, maximum: 140 }
end