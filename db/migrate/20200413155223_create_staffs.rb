class CreateStaffs < ActiveRecord::Migration[6.0]
  def change
    create_table :staffs do |t|
      t.string :name
      t.integer :age
      t.text :description
      t.string :sex
      t.string :img
      

      t.timestamps
    end
  end
end
