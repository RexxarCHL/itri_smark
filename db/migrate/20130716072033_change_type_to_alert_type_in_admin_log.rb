class ChangeTypeToAlertTypeInAdminLog < ActiveRecord::Migration
  def up
  	remove_column :admin_logs, :type
  	add_column :admin_logs, :alert_type, :integer
  end

  def down
  	remove_column :admin_logs, :alert_type
  	add_column :admin_logs, :type, :integer
  end
end
