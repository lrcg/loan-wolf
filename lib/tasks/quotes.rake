namespace :quotes do
	desc 'Truncate and reimport quotes'
	task :import => :environment do
		require 'yaml'
		quotesData = YAML.load_file('db/fixtures/quotes.yml')
		
		Quote.delete_all
		p "Deleted all quotes"

		quotesData.each do |quoteData|
			quote = Quote.new
			quote.text = quoteData['text']
			quote.attribution = quoteData['attribution']
			quote.save
			p "Create a quote record: " + quote.id.to_s
		end
	end
end
