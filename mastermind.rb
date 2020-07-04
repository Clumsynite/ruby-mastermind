# frozen_string_literal: true

# Class to set player role
class Role
  attr_reader :role

  def initialize
    @role = :role
  end

  # Set role when game @starts
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
    code = ''
    arr = []
    4.times { arr.push(rand(1..7)) }
    arr.each do |x|
      code += replace_array_value_to_char(x)
    end
    code
  end

  def replace_array_value_to_char(char)
    case char
    when 1 then 'r'
    when 2 then 'b'
    when 3 then 'y'
    when 4 then 'g'
    when 5 then 'o'
    when 6 then 'v'
    else 'w'
    end
  end
end

# Class to set code if role CodeMaker
class CodeMaker
  attr_reader :code
  def initialize
    @role = Role.new
    @st = true
    @code = :code
  end

  def codemaker_rules
    puts "\nNow you need to set a code for the Codebreaker(me) to guess in 12 turns"
    puts "\nIf your guess has the correct color in the correct position, I'll give it an X"
    puts "Else If the guess has the correct color in the wrong position, I'll give it an O"
    puts 'Else the response will be blank'
    puts "\nCreate a four digit code from the following list of colors using the given values"
    puts "   Red     ->  r\n   Blue    ->  b\n   Yellow  ->  y\n   Green   ->  g"
    puts "   Orange  ->  o\n   violet  ->  v\n   White   ->  w"
  end

  def code_validation
    while @st == true
      print "\nEnter the code you created "
      code = gets.chomp!.downcase
      if !code.match(/[^rgbyvow]/)
        code_in_size(code)
      else
        puts 'Looks like you entered an unknown character'
        next
      end
    end
  end

  def code_in_size(code)
    if code.length == 4
      puts 'Valid Code'
      @code = code
      @st = false
    elsif code.length < 4
      puts 'Code uses less characters'
    elsif code.length > 4
      puts 'Code uses more than required characters'
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
        sleep(rand(1..8))
        print "\nMy guess #{turn}:    "
        guess = @role.random_code
        puts guess
        validate_response(guess, turn)
      end
    end
  end

  def validate_guess(guess, code)
    response = ''
    (0..3).each do |i|
      if guess[i] == code[i]
        response += 'X'
      elsif code.include?(guess[i])
        response += 'O'
      end
    end
    response
  end

  def validate_response(guess, turn)
    response = validate_guess(guess.split(''), code.split(''))
    puts "Response: #{response}"
    if response == 'XXXX'
      puts "\nWoohoo! I lost\nCongratulations! for a sweet win"
      throw :guessed
    elsif response != 'XXXX' && turn == 12
      puts "\nCongratulations! You won\nThe code was #{code}\nI'll try to win next time we play"
      throw :guessed
    end
  end
end

# Class to set code automatically if role CodeBreaker
class CodeBreaker
  attr_reader :code

  def initialize
    @role = Role.new
    @code = :code
    @code_maker = CodeMaker.new
  end

  # Set code automatically by converting random numbers to characters
  def set_code
    puts "\nYou have chosen to be the new CodeBreaker!\nNow wait for me to create a code for you to crack "
    @code = @role.random_code
  end

  # Guess the code in 12 turns and provide a valid response | If response == "XXXX" you win else next turn
  def guess_code
    puts "\nYou'll have 12 turns to guess the color code set by me.\nNot So Good Luck jk\nOptions: r,b,y,g,o,w,v"
    catch(:guessed) do
      (1..12).each do |turn|
        print "\nGuess #{turn}:    "
        #print "#{code} "
        guess = gets.chomp!.downcase
        response = ''
        gc = code.split('')
        g = guess.split('')
        for i in 0..3 do 
          if g[i]==gc[i]
            response += 'X'
          elsif gc.include?(g[i]) 
            response += 'O'
          end
        end
        puts "Response: #{response.split('').shuffle.join('')}"
        if response=='XXXX'
          puts "\nCongratulations! I Lost\nThe code was #{code}"
          throw :guessed
        elsif response!='XXXX' and turn==12
          puts "\nBoohoo! I won\nTHe code was #{code}"
          throw :guessed
        end
      end
    end
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
    if @role.role == 'CodeMaker'
      @maker.set_code
      @maker.guess_code
    elsif @role.role == 'CodeBreaker'
      @breaker.set_code
      @breaker.guess_code 
    end
  end
end

# game = Game.new
# game.start
cm = CodeMaker.new
cm.set_code
puts cm.code
cm.guess_code