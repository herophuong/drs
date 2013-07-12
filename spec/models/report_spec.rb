require 'spec_helper'

describe Report do
  it {should validates_attachment_size :document, :less_than => 1.megabytes}
end
