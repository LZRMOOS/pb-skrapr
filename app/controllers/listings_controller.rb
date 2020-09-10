class ListingsController < ApplicationController
  PB_LARGE_ENDURO_URL = 'https://www.pinkbike.com/buysell/list/?location=194-*-*&category=2,75&price=1000..4500&year=2021,2020&framesize=23,27,34,35,36,30,31,47&wheelsize=11,10'
  MORE_URLS = 'https://www.pinkbike.com/buysell/list/?location=194-*-*&category=2,75,26&price=1000..4500&year=2021,2020&framesize=21,22,28,29,23,27,34,35,36,30,31,47&wheelsize=11,10,13'

  def index
    @listing_details = Listing.all.order('original_post_date DESC, watch_count DESC')
  end

  def synch_with_pb
    @listing_details = Skrapr.run(MORE_URLS)
    @count = Listing.create_from_collection(@listing_details)

    redirect_to listings_path
  rescue StandardError => e
    Rails.logger.info(e)
  end

  def create
    # Listing.create_from_collection(@listing_details)
  end
end
