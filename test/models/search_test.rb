# == Schema Information
#
# Table name: searches
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  url           :string(255)
#  last_synch_at :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
