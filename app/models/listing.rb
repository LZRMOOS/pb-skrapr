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

class Listing < ApplicationRecord
  validates :url, presence: true
  validates_uniqueness_of :url

  def self.create_from_collection(collection)
    collection.each do |item|
      begin
        if (listing = Listing.find_by(url: item[:url]))
          listing.update!(
            price: item[:price],
            last_repost_date: item[:last_repost_date],
            sale_status: item[:sale_status],
            view_count: item[:view_count],
            watch_count: item[:watch_count]
          )
        else
          Listing.create!(item)
        end
      rescue StandardError => e
        Rails.logger.info(e)
      end
    end
  end
end
