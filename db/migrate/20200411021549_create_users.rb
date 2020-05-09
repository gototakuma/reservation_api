class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :age
      t.string :sex
      t.string :password_digest
      t.integer :position
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
