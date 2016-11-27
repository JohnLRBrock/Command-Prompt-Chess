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
    loop do
      puts "Where would you like to move?\nUse format 'a1b2'."
      move = gets.chomp
      return move if valid_move?(move)
    end
  end
  def change_player
    @player = @player == :white ? :black : :white
  end

  def init_game
    game = Chess.new
    loop do
      puts game.board.to_s
      if game.board.mate?(game.mate?(player))
        puts "#{game.player} is in checkmate!"
        game.change_player
        puts "#{game.player} Wins!"
        break
      end
      puts "#{game.player} is in check." if game.board.check?(game.player)
      move = game.player_move
      game.board.move_piece(move) if game.board.legal?(move)
      game.change_player
    end
  end
end
