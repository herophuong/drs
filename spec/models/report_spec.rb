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

require 'spec_helper'

describe Report do
  pending "add some examples to (or delete) #{__FILE__}"
end
