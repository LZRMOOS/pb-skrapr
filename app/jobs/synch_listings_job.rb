class SynchListingsJob < ApplicationJob
  queue_as :default

  def perform(search)
    Rails.logger.info("Synch listings for #{search.name}")
    listing_details = Skrapr.run(search)
    Listing.create_from_collection(listing_details)
  end
end
