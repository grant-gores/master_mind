class Player
  attr_reader :player, :coder

  def initialize
      @player = get_player
      @coder = get_coder
  end

  def get_player
      puts "Welcome to Mastermind! Go to 'https://www.wikihow.com/Play-Mastermind' for more info"
      puts "\nWho is solving the puzzle this game?\nEnter 'Me' or 'Computer':"
      loop do
          input = gets.chomp.capitalize
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
      @player == 'Me' ? 'Computer' : 'Me'
  end
end
