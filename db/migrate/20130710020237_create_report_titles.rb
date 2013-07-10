class CreateReportTitles < ActiveRecord::Migration
  def change
    create_table :report_titles do |t|
      t.string :title
      t.string :guide

      t.timestamps
    end
  end
end
