require 'nokogiri'
require 'open-uri'
NUMBER_OF_ITEMS = 5
SEARCH_ITEM = "ROWER"

doc = Nokogiri::HTML(URI.open("https://www.amazon.pl/s?k=#{SEARCH_ITEM}", 'User-Agent' => 'Safari'))

for row in 2..NUMBER_OF_ITEMS + 1 do
  createdUrl = ('//div[@data-index') + ("=") + ("\"#{row}\"") + ("]")
  responseUrl = doc.css(createdUrl)

  description = responseUrl.css('.a-size-base-plus').text
  price = responseUrl.css('.a-price').text
  link = responseUrl.at_css("a")[:href]

  #Print primary data
  puts description
  puts price[0, price.length/2 + 1]

  #Get details from subpage
  sleep 1
  detailsUrl = Nokogiri::HTML(URI.open("https://www.amazon.pl#{link}", 'User-Agent' => 'Safari'))
  output = detailsUrl.css('//div[@id="feature-bullets"]')
  puts "Detale:"
  output.css('ul li').each do |li|
    puts li.text
  end
  sleep 1
  puts ""

 end