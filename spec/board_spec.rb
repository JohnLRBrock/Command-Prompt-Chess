require 'board'

describe Board do
  before(:each) do
    @board = Board.new
    @move = 'a1b2'
  end
  it "responds to #board_hash" do
    expect(@board).to respond_to(:board_hash)
  end
  describe "#piece_at" do
    it "returns the piece at location" do
      piece = @board.board_hash[:a1]
      expect(@board.piece_at(:a1)).to eql(piece)
    end
  end
  describe "#piece_type_at" do
    it "returns the type of the piece" do
      expect(@board.piece_type_at(:d1)).to eql(:queen)
    end
  end
  describe "#piece_color_at" do
    context "white piece" do
      it "returns :white" do
        expect(@board.piece_color_at(:d1)).to eql(:white)
      end
    end
    context "black piece" do
      it "returns :black" do
        expect(@board.piece_color_at(:e8)).to eql(:black)
      end
    end
  end
  describe "#piece_location at" do
    context ":a1" do
      it "returns :a1" do
        expect(@board.piece_location_at(:a1)).to eql(:a1)
      end
    end
  end
  describe "#start_location" do
    it "returns the first two characters in a move" do
      expect(@board.start_location(@move)).to eql(:a1)
    end
  end
  describe "#end_location" do
    it "returns the last two characters in a move" do
      expect(@board.end_location(@move)).to eql(:b2)
    end
  end
  describe "#move_piece" do
    context "a new board" do
      board = Board.new
      move = 'a1b2'
      board.move_piece(move)
      it "set's the end location to start location" do
        expect(board.piece_type_at(:b2)).to eql(:rook)
        expect(board.piece_color_at(:b2)).to eql(:white)
      end
      it "set's start location to nil" do
        expect(board.board_hash[:a1]).to eql(nil)
      end
      it "set's the piece's location to it's new location" do
        expect(board.piece_at(:b2).location).to eql(:b2)
      end
      it "increments the piece's 'moved' state by one" do
        expect(board.piece_at(:b2).moved).to eql(1)
      end
    end
  end
  describe "#new_loc" do
    context ":d4, 2, 2" do
      it "returns :f6" do
        expect(@board.new_loc(:d4, 2, 2)).to eql(:f6)
      end
    end
    context ":c3, -1, 5" do
      it "returns :b8" do
        expect(@board.new_loc(:c3, -1, 5)).to eql(:b8)
      end
    end
    context ":d4, 5, 1" do
      it "returns false" do
        expect(@board.new_loc(:d4, 5, 1)).to eql(false)
      end
    end
    context ":d4, 1, 5" do
      it "returns false" do
        expect(@board.new_loc(:d4, 1, 5)).to eql(false)
      end
    end
    context ":d4, -5, 1" do
      it "returns false" do
        expect(@board.new_loc(:d4, -5, 1)).to eql(false)
      end
    end
    context ":d4, 1, -5" do
      it "returns false" do
        expect(@board.new_loc(:d4, 1, -5)).to eql(false)
      end
    end
  end
  describe "#legal_pawn_move?" do
    context "new board" do
      context "move pawn one" do
        it "returns true"
      end
      context "move pawn two" do
        it "returns true"
      end
    end
  end
  describe "#legal?" do
    context "new board" do
      context "tries to piece that isn't there" do
        it "returns false" do
          expect(@board.legal?('d4a1')).to eql(false)
        end
      end
    end
    it "returns true if the move is legal"
  end
end