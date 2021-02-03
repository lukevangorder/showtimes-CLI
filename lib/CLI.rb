class CLI
    attr_accessor :name
    def initialize #creates a new CLI instance
        puts "Welcome, please enter your name:"
        @name = gets.strip
        puts "Alright #{@name}, let's get started"
        self.menu
    end
    def menu #the home menu with all options and directory
        options = ["new_stock", "stock_history", "exit_app"]
        puts ""
        puts "Please select an option:"
        puts "1. Check out a new stock"
        puts "2. Look at your check history"
        puts "3. Exit program"
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
        self.menu
    end
end