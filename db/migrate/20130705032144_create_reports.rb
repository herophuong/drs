class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :content
      t.string :attachment

      t.timestamps
    end
  end
end
