puts "Welcome to Mastermind by Clumsyknight"

class Role
    def initialise
        @role = role
    end

    def choose_role
        puts "\nPlease select your role out of the given options(1,2): \n    1. CodeMaker \n    2. CodeBreaker"
        role = gets.chomp!.to_i
        
        if role == 1
            puts "\nYou have selected CodeMaker"
            @role = 'CodeMaker'
            set_code
        elsif role == 2
            puts "\nYou have selected CodeBreaker"
            @role = 'CodeBreaker'
        else
            puts "\nLooks like you have selected something else. Try to enter 1 or 2 to select a role"
        end
    end

    def set_code
        puts "\nNow you need to set a code for the Codebreaker(bot) to guess"
        puts "Select a code from the foll"

    end

    def get_role
        @role
    end

end

r = Role.new
