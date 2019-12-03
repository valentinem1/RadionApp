class Movie < ActiveRecord::Base
  has_many :theaters, through: :showtimes
end
