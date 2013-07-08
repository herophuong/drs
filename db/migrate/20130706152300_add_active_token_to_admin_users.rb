class AddActiveTokenToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :active_token, :string
    add_column :admin_users, :active_token_sent_at, :datetime
  end
end
