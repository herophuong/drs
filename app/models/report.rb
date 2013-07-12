class Report < ActiveRecord::Base
	before_save {|report|
		report.time = Time.now
		report.day = report.time.strftime('%j')
		report.month = report.time.strftime('%m')		
		report.year = report.time.strftime('%Y')
		report.week = report.time.strftime('%W')
    report.fileLink = report.document.url
	}
  attr_accessible :admin_user_id, :content, :day, :fileLink, :month, :report_title_id, :time, :week, :year, :group_id, :document
  attr_accessor :document_file_name
  attr_accessor :document_content_type
  attr_accessor :document_file_size
  attr_accessor :document_updated_at
  validates :content, presence: true
  validates :report_title_id, presence: true
  belongs_to :report_title
  belongs_to :admin_user
  belongs_to :group
      has_attached_file :document
      validates_attachment_size :document,:less_than => 1.megabytes

  
end
