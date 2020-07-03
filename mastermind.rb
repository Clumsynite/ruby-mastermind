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
            code = gets.chomp!.downcase

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
        puts "\nYou have chosen to be the new CodeBreaker!\nNow wait for me to create a code for you to crack "
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

    # Guess the code in 12 turns and provide a valid response | If response == "XXXX" you win else next turn
    def guess_code
        puts "\nYou'll have 12 turns to guess the color code set by me.\nNot So Good Luck jk\nOptions: r,b,y,g,o,w,v"
        catch (:guessed) do
            (1..12).each do |turn|
                print "\nGuess #{turn}:    "
                #print "#{get_code} "
                guess = gets.chomp!.downcase
                response = ""
                gc = get_code.split("")
                g = guess.split("")

                for i in 0..3 do 
                    if g[i]==gc[i]
                        response += 'X'
                    elsif gc.include?(g[i]) 
                        response += 'O'
                    end
                end
                print response.split("").shuffle.join("")
                
                if response=='XXXX'
                    puts "\nCongratulations! I Lost"
                    throw :guessed
                elsif response!='XXXX' and turn==12
                    puts "\nBoohoo! I won"
                    throw :guessed
                end
            end
        end
    end

    # get random code
    def get_code
        @code
    end
end

r = Role.new
cm = CodeMaker.new
cb = CodeBreaker.new
cb.set_code
cb.guess_code