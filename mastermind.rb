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
        puts "\nNow you need to set a code for the Codebreaker(bot) to guess in 12 turns"
        puts "\nIf the guess has the correct color in the correct poisition, it'll receive an X"
        puts "Else If the guess has the correct color in the wrong poisition, it'll receive an O"
        puts "Else the response will be blank "
        puts "\nCreate a four digit code from the following list of colors using the given values"
        puts "   Red     ->  r"
        puts "   Blue    ->  b"
        puts "   Yellow  ->  y"
        puts "   Green   ->  g"
        puts "   Orange  ->  o"
        puts "   violet  ->  v"
        puts "   White   ->  w"
        st = true
        while st==true do  
            print "\nEnter the code you created " 
            code = gets.chomp!

            if !code.match(/[^rgbyovw]/) 
                if code.length==4
                    puts "Valid Code"
                    st = false
                elsif code.length<4
                    puts "Code uses less characters"
                elsif code.length>4
                    "Code uses more than required characters"
                end
            else
                puts "Looks like you entered an unknown character"
                next
            end
        end
    end

    def get_role
        @role
    end

end

r = Role.new
r.set_code