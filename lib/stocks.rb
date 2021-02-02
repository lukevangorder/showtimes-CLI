class Stock
    attr_accessor :symbol, :open, :high, :low, :price, :volume, :latest_trading_day, :previous_close, :change, :change_percent
    @@all = []
    def initialize(symbol)
        API.new(symbol).each do |key, value|
            self.send("#{key}=", "value")
        end
        @@all << self
    end
end

