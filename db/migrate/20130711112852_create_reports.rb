class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :report_title_id
      t.string :content
      t.string :fileLink
      t.timestamp :time
      t.integer :admin_user_id
      t.integer :day
      t.integer :week
      t.integer :month
      t.integer :year
      t.integer :group_id

      t.timestamps
    end
  end
end
