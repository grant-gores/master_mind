class Board
    attr_accessor :master_board, :hint_board
  
    def initialize(player)
        @player = player.player
        @master_board = []
        @hint_board = []
        @code = create_code
    end
  
    def code_values
        ['red', 'blue', 'green', 'yellow', 'white', 'black']
    end
  
    def hint_values
        ['white peg', 'red peg']
    end
  
    def user_generated_code
        puts "\nPlease select 4 colors (in order) to create a code."
        puts "Your color options are: red, blue, green, yellow, white, black"
        puts "Example code: red, blue, blue, yellow\n"
  
        loop do
            input = gets.chomp.downcase.split(",").map(&:strip)
  
            if input.length == 4 && input.all? { |color| code_values.include?(color) }
                puts "The code you selected is: #{input}\n"
                return input
            else
                puts "Invalid input. Enter exactly 4 valid colors."
            end
        end
    end
  
    def computer_generated_code
        puts "The code has been made, you have 12 guesses!"
        puts "Your color options are: red, blue, green, yellow, white, black"
        puts "Example code: red, blue, blue, yellow"
        puts "Remember: 'white peg' means you have one correct color."
        puts "Remember: 'red peg' means you have one correct color **and** position.\n"
        @code = code_values.sample(4) # FIXED: Now stores the generated code
    end
  
    def solve_computer_generated_code
        attempts = 0
        while attempts < 12
            puts "Guess ##{attempts + 1}"
            input = gets.chomp.downcase.split(",").map(&:strip)
  
            if input.length == 4 && input.all? { |color| code_values.include?(color) }
                if input == @code
                    puts "You solved the code: #{@code} in #{attempts + 1} tries"
                    return
                else
                    hint = computer_generated_code_hint(input)
                    puts "Hint: #{hint.join(', ')}" unless hint.empty?
                    puts "Try again."
                end
                attempts += 1  # Only increment if a valid guess is made
            else
                puts "Invalid guess! Enter exactly 4 valid colors."
            end
        end
        puts "You failed to solve the code."
        puts "The correct code was #{@code}"
    end  # <-- FIXED: Properly aligned end
  
    def solve_user_generated_code
        guesses = []
        12.times do |guess_num|
            sample = code_values.sample(4)
            puts "Guess ##{guess_num + 1} -- #{sample}"
            guesses << sample
  
            if sample == @code
                puts "Computer solved the code: #{@code} in #{guess_num + 1} tries!"
                return
            else
                puts "Computer trying again."
            end
        end
        puts "Computer failed to solve the code. The correct code was: #{@code}"
    end
  
    def user_generated_code_hint
        # You can implement this method later
    end
  
    def computer_generated_code_hint(input)
        hints = []
        code_copy = @code.dup # Copy to avoid modifying original
  
        # Step 1: Find exact matches (Red Pegs)
        input.each_with_index do |color, idx|
            if color == @code[idx]
                hints << "Red Peg"
                code_copy[idx] = nil # Remove matched color to prevent duplicate counting
            end
        end
  
        # Step 2: Find color matches in the wrong position (White Pegs)
        input.each_with_index do |color, idx|
            if color != @code[idx] && code_copy.include?(color)
                hints << "White Peg"
                code_copy[code_copy.index(color)] = nil # Remove matched color
            end
        end
  
        hints
    end
  
    def solve_code
        if @player == 'Computer'
            solve_user_generated_code
        else
            solve_computer_generated_code
        end
    end
  
    def create_code
        @player == 'Computer' ? user_generated_code : computer_generated_code
    end
end