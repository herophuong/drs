class ReportTitle < ActiveRecord::Base
  attr_accessible :guide, :title
  has_many :reports
end

