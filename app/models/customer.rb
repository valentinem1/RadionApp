class Customer < ActiveRecord::Base
  has_many :tickets
  has_many :theaters, through: :tickets
end
