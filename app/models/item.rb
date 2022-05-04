class Item < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :stock, presence: true
    validates :unit, presence: true
end
