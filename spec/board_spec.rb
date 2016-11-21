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
  describe "#piece_moved?" do
    context "a piece that hasn't moved" do
      context ":d2" do
        it "returns false" do
          expect(@board.piece_moved?(:d2)).to eql(false)
        end
      end
    end
    context "a piece that has moved" do
      board = Board.new
      board.board_hash[:d2].moved = 1
      context ":d2" do
        it "returns true" do
          expect(board.piece_moved?(:d2)).to eql(true)
        end
      end
    end
  end
  describe "#any_piece?" do
    context "piece at location" do
      it "returns true" do
        expect(@board.any_piece?(:d2)).to eql(true)
      end
    end
    context "no piece at location" do
      it "returns false" do
        expect(@board.any_piece?(:d3)).to eql(false)
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
  describe "#array_of_legal_pawn_moves" do
    context ":white" do
      context "new board" do
        it "returns the array ['f2f3', 'f2f4']" do
          expect(@board.array_of_legal_pawn_moves(:f2)).to eql(['f2f3', 'f2f4'])
        end
      end
      context "pawn on diagnals" do
        board = Board.new
        board.board_hash[:e3] = Piece.new(:pawn, :black, :e3, 3)
        board.board_hash[:g3] = Piece.new(:pawn, :black, :g3, 3)
        it "returns the array ['f2f3', 'f2f4', 'f2g3', 'f2e3']" do
          expect(board.array_of_legal_pawn_moves(:f2)).to eql(['f2f3', 'f2f4', 'f2g3', 'f2e3'])
        end
      end
    end
    context "pawn on fifth file" do
      context "enemy pawn moves up 2" do
        board = Board.new
        board.board_hash[:f5] = Piece.new(:pawn, :white, :f5, 2)
        board.board_hash[:e5] = Piece.new(:pawn, :black, :e5, 1)
        it "returns the array ['f5f6', 'f5e6']" do
          expect(board.array_of_legal_pawn_moves(:f5)).to eql(['f5f6', 'f5e6'])
        end
      end
    end
    context ":black" do
      context "new board" do
        it "returns the array ['f7f6', 'f7f5']" do
          expect(@board.array_of_legal_pawn_moves(:f7)).to eql(['f7f6', 'f7f5'])
        end
      end
      context "pawn on diagnals" do
        board = Board.new
        board.board_hash[:e6] = Piece.new(:pawn, :white, :e6, 3)
        board.board_hash[:g6] = Piece.new(:pawn, :white, :g6, 3)
        it "returns the array ['f7f6', 'f7f5', 'f7g6', 'f7e6']" do
          expect(board.array_of_legal_pawn_moves(:f7)).to eql(['f7f6', 'f7f5', 'f7g6', 'f7e6'])
        end
      end
    end
    context "pawn on fifth file" do
      context "enemy pawn moves up 2" do
        board = Board.new
        board.board_hash[:f4] = Piece.new(:pawn, :black, :f4, 2)
        board.board_hash[:e4] = Piece.new(:pawn, :white, :e4, 1)
        it "returns the array ['f4f3', 'f4e3']" do
          expect(board.array_of_legal_pawn_moves(:f4)).to eql(['f4f3', 'f4e3'])
        end
      end
    end
  end
  describe "#legal_pawn_move?" do
    context ":white pawn" do
      context "new board" do
        context "move pawn one" do
          it "returns true" do
            expect(@board.legal_pawn_move?('f2f3')).to eql(true)
          end
        end
        context "move pawn two" do
          it "returns true" do
            expect(@board.legal_pawn_move?('f2f4')).to eql(true)
          end
        end
      end
      context "enemy pawn directly in front of pawn" do
        board = Board.new
        board.board_hash[:f3] = Piece.new(:pawn, :black, :f3)
        context "move pawn one" do
          it "returns false" do
            expect(board.legal_pawn_move?('f2f3')).to eql(false)
          end
        end
        context "move pawn two" do
          it "returns false" do
            expect(board.legal_pawn_move?('f2f4')).to eql(false)
          end
        end
      end
      context "enemy pawn one space in front of pawn" do
        board = Board.new
        board.board_hash[:f4] = Piece.new(:pawn, :black, :f4)
        context "move pawn one" do
          it "returns true" do
            expect(board.legal_pawn_move?('f2f3')).to eql(true)
          end
        end
        context "move pawn two" do
          it "returns false" do
            expect(board.legal_pawn_move?('f2f4')).to eql(false)
          end
        end
      end
      context "enemy pawn on the diagnals in front of pawn" do
        context "move up and right one" do
        board = Board.new
        board.board_hash[:e3] = Piece.new(:pawn, :black, :e3)
        board.board_hash[:g3] = Piece.new(:pawn, :black, :g3)
          it "returns true" do
            expect(board.legal_pawn_move?('f2g3')).to eql(true)
          end
        end
        context "move up and left one" do
        board = Board.new
        board.board_hash[:e3] = Piece.new(:pawn, :black, :e3)
        board.board_hash[:g3] = Piece.new(:pawn, :black, :g3)
          it "returns true" do
            expect(board.legal_pawn_move?('f2e3')).to eql(true)
          end
        end
        context "a pawn who has moved and try to move two spaces" do
          board = Board.new
          board.board_hash[:f2].moved = 1
          it "returns false" do
            expect(board.legal_pawn_move?('f2f4')).to eql(false)
          end
        end
      end
    end
    context ":black pawn" do
      context "new board" do
        context "move pawn one" do
          it "returns true" do
            expect(@board.legal_pawn_move?('f7f6')).to eql(true)
          end
        end
        context "move pawn two" do
          it "returns true" do
            expect(@board.legal_pawn_move?('f7f5')).to eql(true)
          end
        end
      end
      context "enemy pawn directly in front of pawn" do
        context "move pawn one" do
        board = Board.new
        board.board_hash[:f6] = Piece.new(:pawn, :white, :f6)
          it "returns false" do
            expect(board.legal_pawn_move?('f7f6')).to eql(false)
          end
        end
        context "move pawn two" do
        board = Board.new
        board.board_hash[:f6] = Piece.new(:pawn, :white, :f6)
          it "returns false" do
            expect(board.legal_pawn_move?('f7f5')).to eql(false)
          end
        end
      end
      context "enemy pawn one space in front of pawn" do
        context "move pawn one" do
        board = Board.new
        board.board_hash[:f5] = Piece.new(:pawn, :white, :f5)
          it "returns true" do
            expect(board.legal_pawn_move?('f7f6')).to eql(true)
          end
        end
        context "move pawn two" do
        board = Board.new
        board.board_hash[:f5] = Piece.new(:pawn, :white, :f5)
          it "returns false" do
            expect(board.legal_pawn_move?('f7f5')).to eql(false)
          end
        end
      end
      context "enemy pawn on the diagnals in front of pawn" do
        context "move up and right one" do
        board = Board.new
        board.board_hash[:e6] = Piece.new(:pawn, :white, :e6)
        board.board_hash[:g6] = Piece.new(:pawn, :white, :g6)
          it "returns true" do
            expect(board.legal_pawn_move?('f7g6')).to eql(true)
          end
        end
        context "move up and left one" do
        board = Board.new
        board.board_hash[:e6] = Piece.new(:pawn, :white, :e6)
        board.board_hash[:g6] = Piece.new(:pawn, :white, :g6)
          it "returns true" do
            expect(board.legal_pawn_move?('f7e6')).to eql(true)
          end
        end
      end
      context "a pawn who has moved and try to move two spaces" do
        board = Board.new
        board.board_hash[:f7].moved = 1
        it "returns false" do
          expect(board.legal_pawn_move?('f7f5')).to eql(false)
        end
      end
    end
  end

  describe "#array_of__pawn_moves"

  describe "#legal?" do
    context "new board" do
      context "tries to move piece that isn't there" do
        it "returns false" do
          expect(@board.legal?('d4a1')).to eql(false)
        end
      end
    end
    it "returns true if the move is legal"
  end
end