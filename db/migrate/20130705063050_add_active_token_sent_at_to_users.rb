class AddActiveTokenSentAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active_token_sent_at, :datetime
  end
end
