class CreateVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :visits do |t|
      t.references :account, foreign_key: true
      t.string :visitor_name
      t.string :member_name
      t.references :member, foreign_key: true
      t.string :alexa_session

      t.timestamps
    end
  end
end
