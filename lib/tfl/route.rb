require 'open-uri'
require 'tfl/connection'

module Tfl
  
  class Route
    
    def initialize(page)
      @page = page
    end
    
    def connections
      connection_rows = @page.search('//table[@class="routedetails"]/tr')
      connection_rows.shift # get rid of the first one, which is a header
      connection_rows.pop # get rid of the last one, which is the end point
      
      connection_rows.map do |row_element|
        c = Tfl::Connection.new
        timing_element = row_element.search("/td").first
        timing_array = timing_element.inner_html.split("<br />")
        c.start_time = timing_array.first
        c.end_time = timing_array.last
        c
      end
    end
  end
end