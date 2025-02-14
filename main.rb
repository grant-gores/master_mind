require 'colorize'

class Play
    def start
        player = Player.new
        Board.new(player)
    end
end

class Player
    attr_reader :player, :coder
  
    def initialize
      @player = get_player
      @coder = get_coder
    end
  
    def get_player
      puts "Who is solving the puzzle this game?\nEnter 'Me' or 'Computer':"
      loop do
        input = gets.chomp
        if input == 'Me'
          puts "You selected #{input}\nThe computer will make a code for you to solve!\n"
          return 'Me'
        elsif input == 'Computer'
          puts "You selected #{input}\nMake a code for the computer to solve!\n"
          return 'Computer'
        else
          puts "\nTry Again with valid input of 'Me' or 'Computer'\n"
        end
      end
    end
  
    def get_coder
      if @player == 'Me'
        return 'Computer'
      else
        return 'Me'
      end
    end
end  

class Board
    attr_accessor :master_board, :hint_board
  
    def initialize(player)
      @player = player.player
      @master_board = Array.new()
      @hint_board = []
      @code = create_code
    end

    def code_values
      ['red', 'blue', 'green', 'yellow', 'white', 'black']
    end
      
    def hint_values
      ['white peg','red peg']
    end

    def user_generated_code
        puts "\nPlease select 4 colors (in order) to create a code."
        puts "\nYour color options are: red, blue, green, yellow, white, black"
        puts "\nExample code: red, blue, blue, yellow\n"
        
        loop do
          input = gets.chomp.split(",").map(&:strip)
      
          # Check if the user entered exactly 4 colors
          if input.length == 4
            if input.all? { |color| code_values.include?(color) }
              puts "The code you selected is: #{input}"
              return input
            else
              puts "Please enter valid colors from the available options: red, blue, green, yellow, white, black."
            end
          else
            puts "Enter 4 values for the code!"
          end
        end
    end

    def computer_generated_code
        puts "\nThe computer will now create a code for you to solve."
        puts "The code has been made, you have 12 guesses!"
        puts "Remember: 'white peg' means you have one of the correct colors on the board"
        puts "Remember: 'red peg' means you have the right color and position for one\n"
        code = code_values.sample(4)
        return code
    end

    def create_code
        if @player == 'Computer'
            user_generated_code
        else
            computer_generated_code
        end
    end

end

Play.new.start