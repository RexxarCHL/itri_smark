class AddQuotaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :quota, :integer, default: 0
  end
end
