class CreateAccountLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :account_links do |t|
      t.text :return_to

      t.timestamps
    end
  end
end
