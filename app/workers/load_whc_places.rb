require 'open-uri'

class LoadWHCPlaces
  # include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # recurrence { weekly(4) }

  WHC_URL = 'http://whc.unesco.org/en/list/xml/'	

  def perform 
		response = Faraday.get WHC_URL
		# todo destroy current places table entries
		whc_feed = Nokogiri::XML::Document.parse(response.body) { |config| config.nonet }

		whc_feed.search('row').each do |row|	
			p = Place.new
			['site','latitude','longitude','short_description','image_url','states'].each do |a|
				p[a] = row.search(a).text
			end
			p.save
		end
  end
end