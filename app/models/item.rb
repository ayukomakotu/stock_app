class Item < ApplicationRecord
    has_one :stock
    has_many :reports
    validates :name, presence: true, uniqueness: true
    # validates :stock, presence: true
    validates :unit, presence: true
end
