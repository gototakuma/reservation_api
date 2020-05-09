class CreateCources < ActiveRecord::Migration[6.0]
  def change
    create_table :cources do |t|
      t.string :cource
      t.integer :time
      t.integer :price
      t.boolean :choice, default: false

      t.timestamps
    end
  end
end
