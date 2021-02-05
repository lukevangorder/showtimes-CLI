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
                return error.message
            end
        else
            value = ""
            value.concat("Symbol: #{@symbol}\n")
            value.concat("Open: #{@open}   Price: #{@price}\n")
            value.concat("High: #{@high}   Low:: #{@low}\n")
            value.concat("Volume: #{@volume}   Previous close: #{@previous_close}\n")
            value.concat("Last trading day: #{@latest_trading_day}\n")
            value.concat("Change: #{@change}   Change_percent: #{@change_percent}\n")
            return value
        end
    end
    def self.print_all
        value = ""
        @@all.each do |stock|
            if stock.symbol != nil
                value.concat("#{stock.symbol}, trading at #{stock.price}\n")
            end
        end
        value
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
            return "\nNo information found for entered symbol, please try again\n"
        end
    end
end

