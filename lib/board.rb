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
end

