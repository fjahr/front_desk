class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.belongs_to :user, index: true

      t.string :stripe_id
      t.string :stripe_subscription_id
      t.string :card_brand
      t.string :card_last4
      t.string :card_exp_month
      t.string :card_exp_year
      t.datetime :expires_at

      t.timestamps
    end
  end
end
