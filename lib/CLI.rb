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
        if input.to_i > options.length || input.to_i <= 0
            begin
                raise InputError
            rescue InputError => error 
                error.message
                self.menu
            end
        end
        self.send("#{options[input.to_i - 1]}")
    end
    def exit_app #exits application
        puts "Sad to see you go #{@name}! Come back soon!"
        exit
    end
    def new_stock #takes a stock symbol and creates a Stock object to gather info
        puts "What is the symbol of the stock you wish to learn more about?"
        symbol = gets.strip
        if symbol == ""
            begin
                raise InputError
            rescue InputError => error 
                error.message
                self.new_stock
            end
        end
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
            includes = false
            if input.downcase == "menu"
                self.menu
            else
                Stock.all.each do |stock|
                    if stock.symbol == input.upcase
                        stock.print_info
                        includes = true
                    end
                end
                if includes == false
                    begin
                        raise InputError
                    rescue InputError => error 
                        error.message
                        self.stock_history
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
        elsif input != "Y" || input != "N"
            puts "Invalid user input, self destruct cancelled"
            self.menu
        end
    end
    def update_stock_info #re-requests the api for each existing stock to update their information
        if Stock.all.length > 0
            Stock.refresh
            puts "Stocks in history have been updated!"
            self.menu
        else
            puts "There are no stocks in your history to update #{@name}!"
            self.menu
        end
    end
    def find_stock_symbols #takes user input as a keyword and uses the search class to find possible companies
        puts "Please enter a one word keyword to search for possible related stock symbols"
        input = gets.strip
        if input.include?(" ") || input == ""
            begin
                raise SearchError
            rescue SearchError => error 
                error.message
                self.find_stock_symbols
            end
        end
        Search.new(input).print_results
        self.menu
    end
    class InputError < StandardError #Error for invalid inputs
        def message
            puts ""
            puts "Please input a vaild option"
            puts ""
        end
    end
    class SearchError < StandardError #Error for invalid search input
        def message
            puts ""
            puts "Please input a single keyword"
            puts ""
        end
    end
end