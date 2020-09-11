class SynchListingsJob < ApplicationJob
  queue_as :default

  def perform(search)
    listing_details = Skrapr.run(search)
    Rails.logger.info("Job run")
    Listing.create_from_collection(listing_details)
  end
end
