class Search
    attr_accessor :search_results
    @@all = []
    def initialize(keyword) #creates a search object 
        @keyword = keyword
        @search_results = API.new.url_for_search(keyword)
        @@all << self
    end
    def print_results #returns a printed list of all search results
        list = "\n"
        if @search_results.length == 0
            list.concat("No possible matches found")
        else
            list.concat("Possible matches for your search are:\n")
            @search_results.each do |result|
                list.concat("#{result["2. name"]} - #{result["1. symbol"]}\n")
            end
        end
        list
    end
end