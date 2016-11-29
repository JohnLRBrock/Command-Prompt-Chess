require_relative 'piece'
require_relative 'board'

# TODO:Black pawns sometimes can't pature other pieces
# black pawns can't take piece to the left 
# a3b2 worked
# h7g6 didn't
# g7f6 didn't
# e7f6 worked
# d5c4 didn't
# Black en pasant f4g3 failed
# neither player can take en passant.



class Chess
  attr_accessor :board, :player
  def initialize
    @board = Board.new
    @player = :white
    @previous_board = @board
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
        p hint_for(extract_location(input))
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
  def knight_or_queen
    puts "Your pawn can be promoted. What would you like? (knight/queen)"
    loop do
      input = STDIN.gets.chomp
      return :queen if input == 'queen'
      return :knight if input == 'knight'
      puts "What would you like? (knight/queen)"
    end
  end

  def change_player
    @player = @player == :white ? :black : :white
  end
  def hint?(input)
    return false unless input.length == 7
    array = input.split
    return false unless array.length == 2
    return false unless array[0] == 'hint'
    return false unless ('a'..'h').to_a.include?(array[1][0])
    return false unless (1..8).to_a.include?(array[1][1].to_i)
    true
  end
  def hint_for(loc)
    return "No piece at #{loc}." unless @board.any_piece?(loc)
    array = case @board.piece_type_at(loc)
    when :pawn
      moves = @board.array_of_legal_pawn_moves(loc)
      if @board.piece_color_at(loc) == :white
        move = @board.new_move(loc, @board.new_loc(loc, -1, 1))
        moves << nmove if @board.white_en_passant?(move)
        move = @board.new_move(loc, @board.new_loc(loc, 1, 1))
        moves << move if @board.white_en_passant?(move)
      else
        move = @board.new_move(loc, @board.new_loc(loc, -1, -1))
        moves << move if @board.black_en_passant?(move)
        move = @board.new_move(loc, @board.new_loc(loc, 1, -1))
        moves << move if @board.black_en_passant?(move)
      end
      moves
    when :knight then @board.array_of_legal_knight_moves(loc)
    when :rook then @board.array_of_legal_rook_moves(loc)
    when :bishop then @board.array_of_legal_bishop_moves(loc)
    when :queen then @board.array_of_legal_queen_moves(loc)
    when :king then @board.array_of_legal_king_moves(loc)
    end
    return "There are no moves for #{loc}." if array.empty?
    array
  end
  def extract_location(input)
    input.split[1].to_sym
  end
  def undo_move
    @board = @previous_board
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
    p game.board.array_of_all_moves_for(game.player)
    move = game.player_move
    if game.board.en_passant?(move)
      @previous_board = @board
      game.board.move_en_passant(move)
    else
      @previous_board = @board
      game.board.move_piece(move)
      game.board.promote(game.board.end_location(move), game.knight_or_queen) if game.board.promotion?(game.board.end_location(move))
    end
    game.change_player
  end
end

init_game
