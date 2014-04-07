require 'open-uri'

class LoadWHCPlaces
  # include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # recurrence { weekly(4) }

  WHC_URL = 'http://whc.unesco.org/en/list/xml/'	
  WHC_ATTRIBUTES = ['site','latitude','longitude','short_description','image_url','states','unique_number']

  def perform 
		whc_feed = load_whc_feed
		puts load_whc_feed
		
		if whc_feed.present?
			Place.destroy_all

			whc_feed.search('row').each do |row|	
				create_new_place(row)
			end
		end
	end

	def load_whc_feed
		response = Faraday.get WHC_URL
		Nokogiri::XML::Document.parse(response.body) { |config| config.nonet }
	end

	def create_new_place row
		p = Place.new
		WHC_ATTRIBUTES.each do |a|
			p[a] = row.search(a).text
		end
		p.save
	end
end