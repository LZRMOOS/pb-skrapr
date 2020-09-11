class PurgeOldListingsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info('Purging old listings')
    old_listings = Listing.where('created_at < ?', 30.days.ago)
    old_listings.destroy_all
  end
end
