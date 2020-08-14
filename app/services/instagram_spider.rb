require 'kimurai'

class InstagramSpider < Kimurai::Base
  @name = "instagram_spider"
  @engine = :selenium_chrome
  @start_urls = ["https://instagram.com"]
  @config = {}

  def parse(response, url:, data: {})
    usernames = ['zserbe', 'jklomps', 'samiaouafir']
    login = 'sofianeouafir'
    browser.fill_in "username", with: login
    browser.fill_in "password", with: '4c6t3xxx'
    browser.click_button 'Log In'
    sleep 5
    usernames.each do |username|
      browser.visit("#{url}/#{username}")
      profile_picture_url = browser.all("//img").first[:src]
      user = User.find_or_create_by(username: username, profile_picture_url: profile_picture_url)
      browser.all(:xpath, '//article//a').first.click
      next_button = browser.find(:xpath, "//div[@class='DdSX2']").find("a")
      posts = []
      keep_scrapping = true
      while keep_scrapping
        posted_at = browser.all("//time").first[:datetime]
        location = browser.all(:xpath, "//header").last.text
        location.slice!(username)
        location.slice!('•Following') if location.present?
        posted_at_arr = posts.map(&:posted_at)
        if posts.present? && posted_at_arr.include?(posted_at)
          puts "Scrapping Ended"
          keep_scrapping = false
        else
          post = Post.find_or_create_by(posted_at: posted_at, user: user)
          results = Geocoder.search(location)
          lat = results.first.try(:coordinates).try(:first)
          lng = results.first.try(:coordinates).try(:last)
          country = results.first.try(:country)
          country_code = results.first.try(:country_code)
          if lat.present? && lng.present? && post.persisted?
            country = Country.find_or_create_by(name: country, country_code: country_code)
            place = Place.find_or_create_by(lat: lat, lng: lng, name: location, country: country)
            if place.persisted?
              post.update(place: place)
            end
          end

          puts post.try(:place).try(:name) || "Unknown Location"
          puts post.try(:place).try(:lat)  || "Unknown Latitude"
          puts post.try(:place).try(:lng)  || "Unknown Longitude"
          posts.push(post)
        end
        sleep rand(1...10)
        next_button.click
      end
    end
  end
end
