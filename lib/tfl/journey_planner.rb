require 'mechanize'
require 'tfl/extensions'
require 'tfl/route'

module Tfl
  class JourneyPlanner
    
    HOST = 'journeyplanner.tfl.gov.uk'
    PATH = '/user/XSLT_TRIP_REQUEST2'
    
    def initialize(from, to)
      uri = URI::HTTP.build(
        :host => HOST,
        :path => PATH,
        :query => query_string(from, to)
      )
      
      @agent = WWW::Mechanize.new
      @journey_page = @agent.get(uri)
      
    end
    
    def routes
      @journey_page.search('//table[@class*="jpresults"]//a[@class="jpbutton"]').map do |link|
        page = @agent.get(link[:href])
        Route.new(page)
      end
    end
    
    private
    
    def query_string(from, to)
      {
        'language' => 'en',
        'execInst' => nil,
        'sessionID' => '0',
        'ptOptionsActive' => '-1',
        'place_destination' => 'London',
        'name_destination' => URI.encode(from),
        'type_destination' => 'locator',
        'name_origin' => URI.encode(to),
        'type_origin' => 'locator'
      }.to_params
    end
  end
end