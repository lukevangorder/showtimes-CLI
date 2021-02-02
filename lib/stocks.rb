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
        puts ""
        puts "Symbol: #{@symbol}"
        puts "Open: #{@open}   Price: #{@price}"
        puts "High: #{@high}   Low:: #{@low}"
        puts "Volume: #{@volume}   Previous close: #{@previous_close}"
        puts "Last trading day: #{@latest_trading_day}"
        puts "Change: #{@change}   Change_percent: #{@change_percent}"
    end
    def self.print_all
        @@all.each do |stock|
            puts "#{stock.symbol}, trading at #{stock.price}"
        end
    end
end

