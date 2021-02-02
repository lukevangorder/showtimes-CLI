class CLI
    attr_accessor :name
    def initialize #creates a new CLI instance
        puts "Welcome, please enter your name:"
        @name = gets.strip
        puts "Alright #{@name}, let's get started"
        self.menu
    end
    def menu #the home menu with all options and directory
        options = ["new_stock", "stock_history", "exit_app"]]
        puts "Please select an option:"
        puts "1. Check out a new stock"
        puts "2. Look at your check history"
        puts "3. Exit program"
        input = gets.strip
        self.send("#{options[input - 1]}")
    end
    def exit_app #exits application
        puts "Sad to see you go #{@name}! Come back soon!"
        exit
    end
    def new_stock #takes a stock symbol and creates a Stock object to gather info
        puts "What is the name of the stock symbol you wish to learn more about?"
        symbol = gets.strip
        Stock.new(symbol)
    end
    def stock_history #displays all previously searched stocks
        Stock.print_all
    end
end