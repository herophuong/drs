# == Schema Information
#
# Table name: reports
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  attachment :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Report < ActiveRecord::Base
  attr_accessible :attachment, :content
end
