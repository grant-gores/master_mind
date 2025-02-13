class Board
    attr_accessor :master_board, :hint_board
  
    def initialize
      @master_board = Array.new(4)
      @hint_board = []
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
          break
        elsif input == 'Computer'
          puts "You selected #{input}\nMake a code for the computer to solve!\n"
          return 'Computer'
          break
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