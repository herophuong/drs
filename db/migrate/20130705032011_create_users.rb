class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :active_token
      t.string :state
      t.boolean :manager
      t.string :password_digest

      t.timestamps
    end
  end
end
