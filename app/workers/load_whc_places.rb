require 'open-uri'

class LoadWHCPlaces
  # include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # recurrence { weekly(4) }

  WHC_URL = 'http://whc.unesco.org/en/list/xml/'	
  WHC_ATTRIBUTES = ['site','latitude','longitude','short_description','image_url','states','unique_number']
  WHC_SUBSET = [
		'1953', # Aachen Cathedral
		'467', # Acropolis
		'25', # Ancient City of Bosra
		'1862', # Ancient City of Damascus
		'93', # Ancient Thebes
		'791', # Angkor
		'978', # Pompei
		'41', # Archaeological site of carthage
		'34', # auschwitz birkenau
		'1922', # church of the nativity
		'1433', # bordeaux
		'852', # carlsbad caverns
		'710', # paris banks
		'827', # city of luxembourg
		'1628', # cologne cathedral
		'1883', # fujisan
		'81', # grand canyon
		'782', # himeji-jo
		'917', # hiroshima peace memorial
		'1958', # historiec center of saint petersburg
		'466', # kilimanjaro
		'889', # lake baikal
		'92', # memphis and its acropolis
		'1066', # nikko
		'346', # statue of liberty
		'1633', # stonehenge
		'1211', # jungfrau
		'1457', # sydney opera house
		'281', # agra fort
		'508', # the great wall
		'1768', # persian garden
		'567', # tower of london
		'519', # uluru
		'62', # urnes stave church
		'454', # venice
		'305', # machu picchu
		'304', # cuzco
		'63', # bryggen
		'409', # historic areas of istanbul
		'254', # historic areas of avignon
		'478', # historic center of oazaca
		'84', # independence hall
		'640', # kremlin red square
		'513', # monticello
		'370', # petra
		'846', # rapa nui
		'132', # sagarmatha (everest) national park
		'1032', # summer palace beijing
		'165', # old city of jerusalem and its walls
		'1843', # rio de janeiro
  ]

  def perform 
		whc_feed = load_whc_feed

		if whc_feed.present?
			Place.destroy_all

			whc_feed.search('row').each do |row|	
				if WHC_SUBSET.include? row.search('unique_number').text
					create_new_place(row)
				end
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