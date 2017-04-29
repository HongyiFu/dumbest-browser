require 'uri'
require 'net/http'
require 'nokogiri'

class Page
  attr_reader :uri, :html_body, :html_doc
  
  def initialize(url)
    @uri = URI(url) # or URI.parse(url)
  end
  
  def fetch!
    puts "Fetching..."
    response = Net::HTTP.get_response(@uri)
    @html_body = response.body # this is a string of the html doc now complete with all the html tags
    @html_doc = Nokogiri::HTML(html_body)
  end

  # another way:
  # require 'open-uri'
  # doc = Nokogiri::HTML(open("http://www.threescompany.com/"))
  
  def title
    puts "Title: #{@html_doc.css('title').text}"
  end
  
  def links
    # Research alert!
    # How do you use Nokogiri to extract all the link URLs on a page?
    #
    # These should only be URLs that look like
    #   <a href="http://somesite.com/page.html">Click here!</a>
    # This would pull out "http://somesite.com/page.html"
    links = @html_doc.css('a[href^="http"]')
    if links.length == 0
      puts "There are no external links on the page."
    else 
      puts "List of external links on the page:"
      links.each do |l|
        puts l['href']
      end
    end
  end
end

# Test
# page = Page.new('http://edition.cnn.com/2013/02/06/travel/private-jets/index.html')
# page.fetch!
# puts page.title
# page.links
# below line so that i can load 'page.rb' in irb and get access to @page
# @page = page 
