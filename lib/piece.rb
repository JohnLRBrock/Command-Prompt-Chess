class Piece
  def initialize(type, player, location, moved = false)
    @type = type
    @player = player
    @location = location
    @moved = moved
  end
  def to_s
    case @type
      when :pawn then return @color == :white ? "#{"\u2659"}" : "#{"\u265F"}"
      when :rook then return @color == :white ? "#{"\u2656"}" : "#{"\u265C"}"
      when :knight then return @color == :white ? "#{"\u2658"}" : "#{"\u265E"}"
      when :bishop then return @color == :white ? "#{"\u2657"}" : "#{"\u265D"}"
      when :queen then return @color == :white ? "#{"\u2655"}" : "#{"\u265B"}"
      when :king then return @color == :white ? "#{"\u2654"}" : "#{"\u265A"}"
    end
  end
end