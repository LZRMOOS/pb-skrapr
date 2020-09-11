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

class Search < ApplicationRecord
  has_many :listings

  validates :url,
            presence: true,
            format: { with: /https:\/\/www\.pinkbike\.com\/buysell\/list\/?/,
                      message: 'Must be a pb url' }
  validates :name,
            presence: true,
            length: { minimum: 1, maximum: 40 }

  validates_uniqueness_of :url, :name
end
