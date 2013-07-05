class CreateReportTypes < ActiveRecord::Migration
  def change
    create_table :report_types do |t|
      t.string :title
      t.string :guide
      t.string :string

      t.timestamps
    end
  end
end
