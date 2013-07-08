# == Schema Information
#
# Table name: report_types
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  guide      :string(255)
#  string     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class ReportType < ActiveRecord::Base
  attr_accessible :guide, :string, :title
end
