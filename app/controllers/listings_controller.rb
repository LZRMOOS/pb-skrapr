class ListingsController < ApplicationController
  PB_LARGE_ENDURO_URL = 'https://www.pinkbike.com/buysell/list/?location=194-*-*&category=2,75&price=1000..4500&year=2021,2020&framesize=23,27,34,35,36,30,31,47&wheelsize=11,10'
  PB_ROAD_URL = 'https://www.pinkbike.com/buysell/list/?location=194-*-*&category=26&price=1000..3000&year=2021,2020,2019,2018,2017&framesize=21,22,16,28,29,30&wheelsize=13'

  def index
    @listing_details = Listing.all
  end

  def new
    @listing_details = Skrapr.run(PB_LARGE_ENDURO_URL)
    Listing.create_from_collection(@listing_details)

    redirect_to listings_path
  rescue StandardError => e
    Rails.logger.info(e)
  end

  def create
    # Listing.create_from_collection(@listing_details)
  end
end
