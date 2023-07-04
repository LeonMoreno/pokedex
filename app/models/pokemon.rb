class Pokemon < ApplicationRecord
    validates :name, presence: true
    validates :type_1, presence: true
    validates :total, presence: true
    validates :attack, presence: true
    validates :defense, presence: true
end
