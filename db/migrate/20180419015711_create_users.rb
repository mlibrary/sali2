class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uniqname
      t.string :firstname
      t.string :lastname
      t.string :role
      t.string :unit
      t.boolean :active

      t.timestamps
    end
    add_index :users, :uniqname
  end
end
