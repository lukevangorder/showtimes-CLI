class Stock
    attr_accessor :symbol, :open, :high, :low, :price, :volume, :latest_trading_day, :previous_close, :change, :change_percent
    @@all = []
    def initialize(symbol)
        API.new(symbol).get_hash.each do |key, value|
            if key.to_s.include?(" ")
                okey = key.to_s.split(" ").join("_")
                self.send("#{okey}=", "#{value}")
            else
                self.send("#{key}=", "#{value}")
            end
        end
        @@all << self
    end
    def self.all
        @@all
    end
    def print_info
        if @symbol == nil
            begin
                raise TickerError
            rescue TickerError => error 
                error.message
            end
        else
            puts ""
            puts "Symbol: #{@symbol}"
            puts "Open: #{@open}   Price: #{@price}"
            puts "High: #{@high}   Low:: #{@low}"
            puts "Volume: #{@volume}   Previous close: #{@previous_close}"
            puts "Last trading day: #{@latest_trading_day}"
            puts "Change: #{@change}   Change_percent: #{@change_percent}"
        end
    end
    def self.print_all
        @@all.each do |stock|
            if stock.symbol != nil
                puts "#{stock.symbol}, trading at #{stock.price}"
            end
        end
    end
    def self.delete_all
        @@all = []
    end
    def self.refresh
        symbols = []
        Stock.all.each do |stock|
            symbols << stock.symbol
        end
        Stock.delete_all
        symbols.each do |symbol|
            Stock.new(symbol)
        end
    end
    class TickerError < StandardError
        def message
            puts ""
            puts "No information found for entered symbol, please try again"
            puts ""
        end
    end
end

