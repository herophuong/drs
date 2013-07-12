class AddAttachmentDocumentToReports < ActiveRecord::Migration
  def self.up
    change_table :reports do |t|
      t.attachment :document
    end
  end

  def self.down
    drop_attached_file :reports, :document
  end
end
