class Customer < ActiveRecord::Base
  has_many :theaters, through: :tickets
end
