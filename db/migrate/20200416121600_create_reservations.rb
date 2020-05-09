class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
    	t.string :staff
    	t.datetime :reservation_date
    	t.string :cource
    	t.integer :time
    	t.integer :price
    	t.integer :user_id

      t.timestamps
    end
  end
end
