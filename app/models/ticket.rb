class Ticket < ActiveRecord::Base
    belongs_to :theater
    belongs_to :customer
end
