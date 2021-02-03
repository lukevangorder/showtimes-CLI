class Search
    attr_accessor :search_results
    @@all = []
    def initialize(keyword)
        @keyword = keyword
        @search_results = API.new.url_for_search(keyword)
        @@all << self
    end
    def print_results
        puts ""
        puts "Possible matches for your search are:"
        @search_results.each do |result|
            puts "#{result["2. name"]} - #{result["1. symbol"]}"
        end
    end
end