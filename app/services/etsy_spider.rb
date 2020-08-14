require 'kimurai'

class EtsySpider < Kimurai::Base
  @name = "etsy_spider"
  @engine = :selenium_chrome
  @start_urls = ["https://etsy.com"]
  @config = {}

  def parse(response, url:, data: {})
    browser.fill_in "Search for anything", with: "Toronto Stickers"
    browser.click_button 'Search'
    byebug
  end
end

EtsySpider.crawl!