class CreateContactSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_submissions do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.string :message

      t.timestamps
    end
  end
end
