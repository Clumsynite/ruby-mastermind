puts "Welcome to Mastermind by Clumsyknight"

# Class to set player role 
class Role

    # Set role when game starts
    def set_role
        puts "\nPlease select your role out of the given options(1,2): \n    1. CodeMaker \n    2. CodeBreaker"
        role = gets.chomp!.to_i
        
        if role == 1
            puts "\nYou have selected CodeMaker"
            @role = 'CodeMaker'
            #set_code
        elsif role == 2
            puts "\nYou have selected CodeBreaker"
            @role = 'CodeBreaker'
        else
            puts "\nLooks like you have selected something else. Try to enter 1 or 2 to select a role"
        end
    end

    # get role (whether codebreaker or codemaker)
    def get_role
        @role
    end
end

# Class to set code if role CodeMaker
class CodeMaker
    @code = ""

    # Set code with error handling for human player
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
                    @code = code
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

    def get_code
        @code
    end
end

# Class to set code automatically if role CodeBreaker
class CodeBreaker
    @code = ""

    # Set code automatically by converting random numbers to characters  
    def set_code 
        arr = []
        code = ""
        puts "\nYou have chosen to be the new CodeBreaker!\nNow wait for me to create a code in order to crack"
        (1..4).each{arr.push(rand(1..7))}
        arr.each do |x|
            case x
                when 1 then code+='r'
                when 2 then code+='b'
                when 3 then code+='y'
                when 4 then code+='g'
                when 5 then code+='o'
                when 6 then code+='b'
                when 7 then code+='w'
            end
        end
        @code = code
    end

    # get random code
    def get_code
        @code
    end
end

r = Role.new
cm = CodeMaker.new
cb = CodeBreaker.new