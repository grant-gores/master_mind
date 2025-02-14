require 'colorize'
require_relative './lib/board'
require_relative './lib/player'

class Main
    def start
        player = Player.new
        board = Board.new(player)
        board.solve_code
    end
end

Main.new.start