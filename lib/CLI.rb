class CLI
    attr_accessor :name
    def initialize #creates a new CLI instance
        puts "Welcome, please enter your name:"
        @name = gets.strip
        puts "Alright #{@name}, let's get started"
        self.menu
    end
    def menu #the home menu with all options and directory
        options = ["new_stock", "find_stock_symbols", "stock_history", "clear_history", "update_stock_info", "exit_app"]
        puts ""
        puts "Please select an option:"
        puts "1. Check out a new stock"
        puts "2. Search for stock symbols"
        puts "3. Look at your check history"
        puts "4. Clear your history"
        puts "5. Update all researched stocks"
        puts "6. Exit program"
        input = gets.strip
        self.send("#{options[input.to_i - 1]}")
    end
    def exit_app #exits application
        puts "Sad to see you go #{@name}! Come back soon!"
        exit
    end
    def new_stock #takes a stock symbol and creates a Stock object to gather info
        puts "What is the symbol of the stock you wish to learn more about?"
        symbol = gets.strip
        symbol.upcase!
        Stock.new(symbol).print_info
        self.menu
    end
    def stock_history #displays all previously searched stocks, then asks if the user wants to see any of them in detail
        if Stock.all.length > 0
            puts ""
            puts "Okay #{@name}, these are the researched stocks in your history:"
            Stock.print_all
            puts ""
            puts "Do you want to see any of these stocks in detail? Type the stock symbol if you'd like to, or say menu to return"
            input = gets.strip
            if input.downcase == "menu"
                self.menu
            else
                Stock.all.each do |stock|
                    if stock.symbol == input.upcase
                        stock.print_info
                    end
                end
            end
            self.stock_history
        else
            puts "You have no stocks in your search history #{@name}!"
            self.menu
        end
    end
    def clear_history #removes all previously researched stocks
        puts "Are you sure you want to clear your history and erase all previously viewed stocks? (Y/N)"
        input = gets.strip
        input.upcase!
        if input == "N"
            puts "Self destruct cancelled"
            self.menu
        elsif input == "Y"
            Stock.delete_all
            puts "History deleted"
            self.menu
        end
    end
    def update_stock_info #re-requests the api for each existing stock to update their information
        if Stock.all.length > 0
            symbols = []
            Stock.all.each do |stock|
                symbols << stock.symbol
            end
            Stock.delete_all
            symbols.each do |symbol|
                Stock.new(symbol)
            end
            puts "Stocks in history have been updated!"
            self.menu
        else
            puts "There are no stocks in your history to update #{@name}!"
            self.menu
        end
    end
    def find_stock_symbols
        puts "Please enter a word to search for possible related stock symbols"
        input = gets.strip
        Search.new(input).print_results
        self.menu
    end
end