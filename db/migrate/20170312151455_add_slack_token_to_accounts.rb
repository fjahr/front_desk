class AddSlackTokenToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :slack_token, :string
    add_column :accounts, :slack_webhook, :string
  end
end
