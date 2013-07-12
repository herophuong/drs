class Report < ActiveRecord::Base
	before_save {|report|
		report.time = Time.now
		report.day = report.time.strftime('%j')
		report.month = report.time.strftime('%m')		
		report.year = report.time.strftime('%Y')
		report.week = report.time.strftime('%W')
	}
  attr_accessible :admin_user_id, :content, :day, :fileLink, :month, :report_title_id, :time, :week, :year, :group_id
  validates :content, presence: true
  validates :report_title_id, presence: true
  belongs_to :report_title
  belongs_to :admin_user
  belongs_to :group

  

  
end
