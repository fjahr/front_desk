class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.references :account, foreign_key: true
      t.string :name
      t.string :email
      t.string :phone
      t.string :slack_id
      t.string :hipchat_id

      t.timestamps
    end
  end
end
