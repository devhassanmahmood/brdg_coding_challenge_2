class CreateContactOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_options do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email, null: false
      t.jsonb  :intros_offered, default: {}
      t.integer :ranking, default: 3
      t.integer :contact_option
      t.timestamps
    end
  end
end
