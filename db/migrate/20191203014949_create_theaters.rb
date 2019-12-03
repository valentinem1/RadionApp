class CreateTheaters < ActiveRecord::Migration[5.2]
  def change
    create_table :theaters do |t|
      t.string :theater_name
      t.datetime :schedule
      t.string :location
    end
  end
end
