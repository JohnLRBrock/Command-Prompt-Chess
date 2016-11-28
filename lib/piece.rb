class Piece
  attr_accessor :type, :player, :location, :moved, :last_moved_on
  def initialize(type, player, location, moved = 0, last_moved_on = 0)
    @type = type
    @player = player
    @location = location
    @moved = moved
    @last_moved_on = last_moved_on
  end
  def to_s
    case @type
      when :pawn then return @player == :white ? "WP" : "BP"
      when :rook then return @player == :white ? "WR" : "BR"
      when :knight then return @player == :white ? "WN" : "BN"
      when :bishop then return @player == :white ? "WB" : "BB"
      when :queen then return @player == :white ? "WQ" : "BQ"
      when :king then return @player == :white ? "WK" : "BK"
      #when :pawn then return @player == :white ? "#{"\u2659"}" : "#{"\u265F"}"
      #when :rook then return @player == :white ? "#{"\u2656"}" : "#{"\u265C"}"
      #when :knight then return @player == :white ? "#{"\u2658"}" : "#{"\u265E"}"
      #when :bishop then return @player == :white ? "#{"\u2657"}" : "#{"\u265D"}"
      #when :queen then return @player == :white ? "#{"\u2655"}" : "#{"\u265B"}"
      #when :king then return @player == :white ? "#{"\u2654"}" : "#{"\u265A"}"
    end
  end
end