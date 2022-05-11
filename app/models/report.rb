class Report < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates :process, presence: true
  validates :process_number, presence: true
  validates :day, presence: true
end
