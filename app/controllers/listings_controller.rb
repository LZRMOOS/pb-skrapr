class ListingsController < ApplicationController
  PB_LARGE_ENDURO_URL = 'https://www.pinkbike.com/buysell/list/?location=194-*-*&category=2,75&price=1000..4500&year=2021,2020&framesize=23,27,34,35,36,30,31,47&wheelsize=11,10'
  MORE_URLS = 'https://www.pinkbike.com/buysell/list/?location=194-*-*&category=2,75,26&price=1000..4500&year=2021,2020&framesize=21,22,28,29,23,27,34,35,36,30,31,47&wheelsize=11,10,13'

  def index
    @listing_details = Listing.all.order('original_post_date DESC, watch_count DESC')
    @searches = Search.all.order('last_synch_at DESC')
  end

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_required_params)

    if @search.save!
      flash[:notice] = 'Search created!'
      redirect_to listings_path
    else
      render 'new'
    end
  end

  def destroy
    @search = Search.find(params[:id])
    @search.destroy!
    flash[:notice] = 'Search deleted!'

    render 'index'
  end

  def synch_with_pb(search_to_synch: MORE_URLS)
    @listing_details = Skrapr.run(search_to_synch)
    @count = Listing.create_from_collection(@listing_details)

    redirect_to listings_path
  rescue StandardError => e
    Rails.logger.info(e)
  end

  private

  def search_required_params
    params.require(:search).permit(:name, :url)
  end
end
