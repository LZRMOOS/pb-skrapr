class Listing < ApplicationRecord
  validates :url, presence: true
  validates_uniqueness_of :url

  def self.create_from_collection(collection)
    collection.each do |item|
      begin
        Listing.create!(item)
      rescue StandardError => e
        Rails.logger.info(e)
      end
    end
  end
end
