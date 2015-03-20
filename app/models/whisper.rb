class Whisper < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  validates :content, length: { maximum: 140 }, presence: true
end
