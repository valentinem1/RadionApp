class Theater < ActiveRecord::Base    
    has_many :customers, through: :tickets
end