class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin_user, :boolean, default: false
  end
end
