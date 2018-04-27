class CreateSessionRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :session_requests do |t|
      t.references :requested_by
      t.references :contact_person
      t.string :title
      t.string :state
      t.integer :expected_attendance
      t.boolean :course_related
      t.boolean :library_location_required
      t.boolean :evaluation_needed
      t.boolean :registration_needed
      t.text :notes
      t.text :accommodations
      t.timestamps
    end
  end
end

