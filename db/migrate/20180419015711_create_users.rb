class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uniqname
      t.string :firstname
      t.string :lastname
      t.string :role
      t.string :calendar_url
      t.string :access_token
      t.string :refresh_token
      t.string :records_per_page
      t.string :unit
      t.string :crypted_password
      t.string :salt
      t.boolean :active
      t.boolean :notify_new_request

      t.timestamps
    end
    add_index :users, :uniqname
  end
end
