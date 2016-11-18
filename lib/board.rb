require_relative 'piece'

class Board
  attr_accessor :board_hash
  def initialize
    @board_hash = 
    {
    a1: Piece.new(:rook, :white, :a1),
    b1: Piece.new(:knight, :white, :b1),
    c1: Piece.new(:bishop, :white, :c1),
    d1: Piece.new(:queen, :white, :d1),
    e1: Piece.new(:king, :white, :e1),
    f1: Piece.new(:bishop, :white, :f1),
    g1: Piece.new(:knight, :white, :d1),
    h1: Piece.new(:rook, :white, :h1),
    a2: Piece.new(:pawn, :white, :a2),
    b2: Piece.new(:pawn, :white, :b2),
    c2: Piece.new(:pawn, :white, :c2),
    d2: Piece.new(:pawn, :white, :d2),
    e2: Piece.new(:pawn, :white, :e2),
    f2: Piece.new(:pawn, :white, :f2),
    g2: Piece.new(:pawn, :white, :g2),
    h2: Piece.new(:pawn, :white, :h2),
    a8: Piece.new(:rook, :black, :a8),
    b8: Piece.new(:knight, :black, :b8),
    c8: Piece.new(:bishop, :black, :c8),
    d8: Piece.new(:queen, :black, :d8),
    e8: Piece.new(:king, :black, :e8),
    f8: Piece.new(:bishop, :black, :f8),
    g8: Piece.new(:knight, :black, :g8),
    h8: Piece.new(:rook, :black, :h8),
    a7: Piece.new(:pawn, :black, :a7),
    b7: Piece.new(:pawn, :black, :b7),
    c7: Piece.new(:pawn, :black, :c7),
    d7: Piece.new(:pawn, :black, :d7),
    e7: Piece.new(:pawn, :black, :e7),
    f7: Piece.new(:pawn, :black, :f7),
    g7: Piece.new(:pawn, :black, :g7),
    h7: Piece.new(:pawn, :black, :h7)
    }
  end
  def each(&block)
    8.downto(1) do |i|
      ('a'..'h').each do |j| 
        yield(@board_state[(i.to_s + j).to_sym])
      end
    end
  end
  def to_s
    string = "\n\n"
    8.downto(1) do |numeral|
      string << numeral.to_s + ' '
      ('a'..'h').each do |alpha|
        location = "#{alpha + numeral.to_s}".to_sym
        if @board_hash[location]
          string << @board_hash[location].to_s
        else
          string << '__'
        end
        string << ' '
      end
      string << "\n\n"
    end
    string << '  '
    ('a'..'h').each { |n| string << n.to_s + '  ' }
    string
  end

  def piece_at(location)
    @board_hash[location]
  end
  def piece_type_at(location)
    board_hash[location].type
  end
  def piece_color_at(location)
    board_hash[location].player
  end
  def piece_location_at(location)
    board_hash[location].location
  end

  # returns the first two characters in a move
  # example: given 'a1b2' returns :a1
  def start_location(move)
    move.split(//).first(2).join('').to_sym
  end
  # returns the last two characters in a move
  # example: given 'a1b2' returns :b2
  def end_location(move)
    move.split(//).last(2).join('').to_sym
  end

  def move_piece(move)
    start_loc = start_location(move)
    end_loc = end_location(move)
    @board_hash[end_loc] = @board_hash[start_loc]
    @board_hash[start_loc] = nil
    @board_hash[end_loc].location = end_loc
    @board_hash[end_loc].moved += 1
  end
end
