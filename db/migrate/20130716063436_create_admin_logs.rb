class CreateAdminLogs < ActiveRecord::Migration
  def change
    create_table :admin_logs do |t|
      t.integer :type
      t.string :message
      t.string :link
      t.string :from

      t.timestamps
    end
  end
end
