json.extract! member, :id, :account_id, :name, :email, :phone, :slack_id, :hipchat_id, :created_at, :updated_at
json.url member_url(member, format: :json)