class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string, null: false, default: ""
    add_column :users, :userid, :string, null: false, default: ""
    add_column :users, :avatar, :string
  end
end
