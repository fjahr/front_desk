class CreateAliases < ActiveRecord::Migration[5.0]
  def change
    create_table :aliases do |t|
      t.references :member, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
