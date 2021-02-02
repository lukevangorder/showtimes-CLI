require 'net/http'
require 'open-uri'
require 'json'
require 'pry'
class API
    KEY = "SJX60ELDFC51X4HK"
    def initialize(symbol, function = "GLOBAL_QUOTE", interval = "1min") #sends HTTP request and recieves the body of the request
        url = "https://www.alphavantage.co/query?function=#{function}&symbol=#{symbol}&interval=#{interval}&apikey=#{KEY}"
        uri = URI.parse(url)
        response = JSON.parse(Net::HTTP.get_response(uri).body)
        return_hash = {}
        response["Global Quote"].each do |key, value|
            return_hash[key.slice(4, key.length-1).to_sym] = value
        end
        return_hash
    end
end
API.new("GME")
