class Item < ApplicationRecord
    has_one :stock
    validates :name, presence: true, uniqueness: true
    # validates :stock, presence: true
    validates :unit, presence: true
end
