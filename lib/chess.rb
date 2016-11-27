require_relative 'piece'
require_relative 'board'

class Chess
  attr_accessor :board, :player
  def initialize
    @board = Board.new
    @player = :white
  end
  def valid_move?(move)
    if move.length == 4
      if (1..8).to_a.include?(move[1].to_i) && (1..8).to_a.include?(move[3].to_i)
        if ('a'..'h').to_a.include?(move[0]) && ('a'..'h').to_a.include?(move[2])
          return true
        end
      end
    end
    false
  end
  def player_move
    puts "Where would you like to move?\nUse format 'a1b2'."
    loop do
      move = gets.chomp
      unless valid_move?(move)
        puts "That's not a valid move."
        redo
      end
      unless @board.legal?(move)
        puts "That's not a legal move."
        redo
      end
      unless @board.piece_color_at(@board.start_location(move)) == player
        puts "That's not your peice to move."
        redo
      end
      return move
    end
  end
  def change_player
    @player = @player == :white ? :black : :white
  end
end
def init_game
  game = Chess.new
  loop do
    puts game.board.to_s
    if game.board.mate?(game.player)
      puts "#{game.player} is in checkmate!"
      game.change_player
      puts "#{game.player} Wins!"
      break
    end
    puts "#{game.player} is in check." if game.board.check?(game.player)
    game.board.move_piece(game.player_move)
    game.change_player
  end
end

init_game
