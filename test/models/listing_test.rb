# == Schema Information
#
# Table name: listings
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  url                :string(255)
#  category           :string(255)
#  price              :string(255)
#  original_post_date :date
#  last_repost_date   :date
#  sale_status        :string(255)
#  view_count         :integer
#  watch_count        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
