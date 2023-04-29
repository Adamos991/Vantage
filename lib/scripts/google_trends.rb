require "selenium-webdriver"
require "uri"

driver = Selenium::WebDriver.for :chrome
driver.navigate.to "https://trends.google.com/trends/trendingsearches/realtime?geo=US&hl=en-US&category=all"

sleep(5)

# Accept the cookie banner if present
begin
  cookie_accept_button =
    driver.find_element(
      css:
        "#cookieBar .cookieBarInner .cookieBarButtons .cookieBarConsentButton"
    )
  cookie_accept_button.click
  sleep(2)
rescue Selenium::WebDriver::Error::NoSuchElementError
  puts "No cookie banner found."
end

# Click the "Load more" button 5 times
5.times do
  begin
    load_more_button = driver.find_element(css: ".feed-load-more-button")
    load_more_button.click
    sleep(2)
  rescue Selenium::WebDriver::Error::NoSuchElementError
    puts "No more 'Load more' button found."
    break
  end
end

trends = driver.find_elements(css: ".title")
Trend.destroy_all
trends.each do |trend|
  name = trend.text
  encoded_name = URI.encode_www_form_component(name)
  url = "https://www.google.com/search?q=#{encoded_name}"
  Trend.create!(name: name, url: url)
end

driver.quit
