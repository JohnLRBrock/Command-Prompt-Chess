require_relative 'piece'
require_relative 'board'

# TODO:Black pawns sometimes can't pature other pieces
# black pawns can't take piece to the left 
# a3b2 worked
# h7g6 didn't
# g7f6 didn't
# e7f6 worked
# d5c4 didn't
# neither player can take en passant.
# Tell players who turn it is.



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
    puts "#{@player}'s turn.\nWhere would you like to move?\nUse format 'a1b2' or ask for a hint with 'hint a1'."
    loop do
      input = STDIN.gets.chomp
      if hint?(input)
        puts hint_for(extract_location(input))
        redo
      end
      unless valid_move?(input)
        puts "That's not a valid move."
        redo
      end
      unless @board.legal?(input)
        puts "That's not a legal move."
        redo
      end
      unless @board.piece_color_at(@board.start_location(input)) == player
        puts "That's not your peice to move."
        redo
      end
      return input
    end
  end
  def change_player
    @player = @player == :white ? :black : :white
  end
  def hint?(input)
    false
  end
  def hint_for(loc)
    'Not yet implemented'
  end
  def extract_location(input)
    nil
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
    move = game.player_move
    if game.board.en_passant?(move)
      game.board.move_en_passant(move)
    else
      game.board.move_piece(move)
    end
    game.change_player
  end
end

init_game
