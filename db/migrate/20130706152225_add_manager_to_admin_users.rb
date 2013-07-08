class AddManagerToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :manager, :boolean
  end
end
