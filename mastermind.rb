# frozen_string_literal: true

# Class to set player role
class Role
  # Set role when game starts
  def set_role
    puts "\nPlease select your role out of the given options(1,2): \n    1. CodeMaker \n    2. CodeBreaker"
    role = gets.chomp!.to_i
    if role == 1
      puts "\nYou have selected CodeMaker"
      @role = 'CodeMaker'
      # set_code
    elsif role == 2
      @role = 'CodeBreaker'
    else
      puts "\nLooks like you have selected something else. Try to enter 1 or 2 to select a role"
    end
  end

  # Generate a random code 
  def random_code
    code = "";arr = [];
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
    end;code;
  end

  # get role (whether codebreaker or codemaker)
  def get_role
    @role
  end
end

# Class to set code if role CodeMaker
class CodeMaker
  @code = ""

  def initialize
    @role = Role.new
  end

  def codemaker_rules
    puts "\nNow you need to set a code for the Codebreaker(me) to guess in 12 turns"
    puts "\nIf your guess has the correct color in the correct position, I'll give it an X"
    puts "Else If the guess has the correct color in the wrong position, I'll give it an O\nElse the response will be blank "
    puts "\nCreate a four digit code from the following list of colors using the given values"
    puts "   Red     ->  r\n   Blue    ->  b\n   Yellow  ->  y\n   Green   ->  g"
    puts "   Orange  ->  o\n   violet  ->  v\n   White   ->  w"
  end

  def code_validation
    st = true
    while st==true do  
      print "\nEnter the code you created " 
      code = gets.chomp!.downcase
      if !code.match(/[^rgbyovw]/) 
        code_in_size(code)
      else
        puts "Looks like you entered an unknown character"
        next
      end
    end
  end
  
  def code_in_size(code)
    if code.length==4
      puts "Valid Code"
      @code = code
      st = false
    elsif code.length<4
      puts "Code uses less characters"
    elsif code.length>4
      puts "Code uses more than required characters"
    end
  end

  # Set code with error handling for human player
  def set_code
    codemaker_rules
    code_validation
  end

  # guess code randomly in 12 turns 
  def guess_code
      puts "\nI have 12 turns to guess the color code that you have set.\nLet's see whether I can do it or not"
      catch(:guessed) do
        (1..12).each do |turn|
            sleep(rand(1..10))
            print "\nMy guess #{turn}:    "
            guess = @role.random_code
            puts guess
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
            puts "Response: #{response.split("").shuffle.join("")}"
            if response=='XXXX'
              puts "\nWoohoo! I lost\nCongratulations! for a sweet win"
              throw :guessed
            elsif response!='XXXX' and turn==12
              puts "\nCongratulations! You won\nThe code was #{get_code}\nI'll try to win next time we play"
              throw :guessed
            end
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

  def initialize
    @role = Role.new
  end
  
  # Set code automatically by converting random numbers to characters  
  def set_code 
    puts "\nYou have chosen to be the new CodeBreaker!\nNow wait for me to create a code for you to crack "
    @code =  @role.random_code
  end

  # Guess the code in 12 turns and provide a valid response | If response == "XXXX" you win else next turn
  def guess_code
    puts "\nYou'll have 12 turns to guess the color code set by me.\nNot So Good Luck jk\nOptions: r,b,y,g,o,w,v"
    catch(:guessed) do
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
        puts "Response: #{response.split("").shuffle.join("")}"
        if response=='XXXX'
          puts "\nCongratulations! I Lost\nThe code was #{get_code}"
          throw :guessed
        elsif response!='XXXX' and turn==12
          puts "\nBoohoo! I won\nTHe code was #{get_code}"
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

# Main class to play Mastermind
class Game
  def initialize        
    @role = Role.new
    @maker = CodeMaker.new
    @breaker = CodeBreaker.new
  end

  def start
    puts "Welcome to Mastermind by Clumsyknight"
    @role.set_role
    if @role.get_role == 'CodeMaker'
      @maker.set_code
      @maker.guess_code
    elsif @role.get_role == 'CodeBreaker'
      @breaker.set_code
      @breaker.guess_code 
    end
  end
end

# game = Game.new
# game.start

r = Role.new
puts r.random_code