class Theater < ActiveRecord::Base 
    has_many :tickets   
    has_many :customers, through: :tickets
    has_many :showtimes   
    has_many :movies, through: :showtimes

end