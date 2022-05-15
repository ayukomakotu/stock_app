class User < ApplicationRecord
    has_many :reports
    validates :name, presence: true
    validates :number, presence: true, uniqueness: true

end
