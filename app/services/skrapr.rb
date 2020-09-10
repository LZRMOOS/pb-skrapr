require 'nokogiri'
require 'open-uri'
require 'pry'

class Skrapr
  class << self
    BUY_SELL_REGEX = /https:\/\/www\.pinkbike\.com\/buysell\/\d{7}/

    def run(url_to_scrape)
      listing_urls = find_listings_urls(url_to_scrape)

      scrape_listings(listing_urls)
    end

    private

    def find_listings_urls(url_to_scrape)
      listing_urls = []
      html = open(url_to_scrape)
      doc = Nokogiri::HTML(html)

      listings_on_pg = doc.css('.filtered-search-results').css('.bsitem').css('a')

      listings_on_pg.each do |listing|
        listing_url = listing.attribute('href').value
        next unless BUY_SELL_REGEX =~ listing_url
        Rails.logger.info(listing_url)
        listing_urls << listing_url
      end

      next_page_url = doc.css('.next-page').css('a').attribute('href').value

      until next_page_url.nil?
        listing_url = "https://www.pinkbike.com/buysell/list/#{next_page_url}"

        html = open(listing_url)
        doc = Nokogiri::HTML(html)
        next_page_url = doc&.css('.next-page')&.css('a')&.attribute('href')&.value

        listings_on_pg = doc.css('.filtered-search-results').css('.bsitem').css('a')

        listings_on_pg.each do |listing|
          listing_url = listing.attribute('href').value
          next unless BUY_SELL_REGEX =~ listing_url
          listing_urls << listing_url
        end
      end
      listing_urls.uniq
    end

    def scrape_listings(listing_urls)
      listing_details = []
      listing_urls.each do |url|
        html = open(url)
        doc = Nokogiri::HTML(html)

        title = doc.css('.buysell-title').text
        price = doc.css('.buysell-price').last.children[0].text.strip

        category = doc.css('.buysell-details-column').first.children[2].text.strip

        original_post_date = Date.parse(doc.css('.buysell-details-column').last.children[2].text.strip)
        last_repost_date = Date.parse(doc.css('.buysell-details-column').last.children[6].text.strip)
        sale_status = doc.css('.buysell-details-column').last.children[11].text.strip
        view_count = doc.css('.buysell-details-column').last.children[16].text.strip.to_i
        watch_count = doc.css('.buysell-details-column').last.children[20].text.strip.to_i

        next unless original_post_date > Time.new.to_date - 10

        params = {
          url: url,
          title: title,
          price: price,
          category: category,
          original_post_date: original_post_date,
          last_repost_date: last_repost_date,
          sale_status: sale_status,
          view_count: view_count,
          watch_count: watch_count
        }
        Rails.logger.info(params)
        listing_details << params
      end
      listing_details.uniq
    end
  end
end
