class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.integer :customer_id
      t.integer :theater_id
    end
  end
end
