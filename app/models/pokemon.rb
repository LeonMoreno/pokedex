class Pokemon < ApplicationRecord
    # self.per_page = 20
    validates :name, presence: true
    validates :type_1, presence: true
    validates :total, presence: true
    validates :attack, presence: true
    validates :defense, presence: true
end
