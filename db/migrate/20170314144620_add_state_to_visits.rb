class AddStateToVisits < ActiveRecord::Migration[5.0]
  def change
    add_column :visits, :state, :string
  end
end
