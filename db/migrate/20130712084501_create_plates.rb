class CreatePlates < ActiveRecord::Migration
  def change
    create_table :plates do |t|
      t.integer :user_id
      t.string :plateNo

      t.timestamps
    end

    add_index :plates, :user_id
  end
end
