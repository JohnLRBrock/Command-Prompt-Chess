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
          expect(@board.array_of_legal_pawn_moves(:f2)).to eql(['f2f3', 'f2f4'].sort!)
        end
      end
      context "pawn on diagnals" do
        board = Board.new
        board.board_hash[:e3] = Piece.new(:pawn, :black, :e3, 3)
        board.board_hash[:g3] = Piece.new(:pawn, :black, :g3, 3)
        it "returns the array ['f2f3', 'f2f4', 'f2g3', 'f2e3']" do
          expect(board.array_of_legal_pawn_moves(:f2)).to eql(['f2f3', 'f2f4', 'f2g3', 'f2e3'].sort!)
        end
      end
    end
    context "pawn on fifth file" do
      context "enemy pawn moves up 2" do
        board = Board.new
        board.board_hash[:f5] = Piece.new(:pawn, :white, :f5, 2)
        board.board_hash[:e5] = Piece.new(:pawn, :black, :e5, 1)
        it "returns the array ['f5f6', 'f5e6']" do
          expect(board.array_of_legal_pawn_moves(:f5)).to eql(['f5f6', 'f5e6'].sort!)
        end
      end
    end
    context ":black" do
      context "new board" do
        it "returns the array ['f7f6', 'f7f5']" do
          expect(@board.array_of_legal_pawn_moves(:f7)).to eql(['f7f6', 'f7f5'].sort!)
        end
      end
      context "pawn on diagnals" do
        board = Board.new
        board.board_hash[:e6] = Piece.new(:pawn, :white, :e6, 3)
        board.board_hash[:g6] = Piece.new(:pawn, :white, :g6, 3)
        it "returns the array ['f7f6', 'f7f5', 'f7g6', 'f7e6']" do
          expect(board.array_of_legal_pawn_moves(:f7)).to eql(['f7f6', 'f7f5', 'f7g6', 'f7e6'].sort!)
        end
      end
    end
    context "pawn on fifth file" do
      context "enemy pawn moves up 2" do
        board = Board.new
        board.board_hash[:f4] = Piece.new(:pawn, :black, :f4, 2)
        board.board_hash[:e4] = Piece.new(:pawn, :white, :e4, 1)
        it "returns the array ['f4f3', 'f4e3']" do
          expect(board.array_of_legal_pawn_moves(:f4)).to eql(['f4f3', 'f4e3'].sort!)
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

  describe "#array_of_legal_rook_moves" do
    context "new board" do
      it "returns []" do
        expect(@board.array_of_legal_rook_moves(:a1)).to eql([])
      end
    end
    context "rook at :d4" do
      board = Board.new
      board.board_hash[:d4] = Piece.new(:rook, :white, :d4, 5)
      it "returns ['d4a4', 'd4b4', 'd4c4', 'd4e4', 'd4f4', 'd4g4', 'd4h4', 'd4d3', 'd4d5', 'd4d6', 'd4d7']" do
        expect(board.array_of_legal_rook_moves(:d4)).to eql(['d4a4', 'd4b4', 'd4c4', 'd4e4', 'd4f4', 'd4g4', 'd4h4', 'd4d3', 'd4d5', 'd4d6', 'd4d7'].sort!)
      end
    end
  end

  describe "#legal_rook_move?" do
    context ":white" do
      context ":f4" do
        board = Board.new
        board.board_hash[:f4] = Piece.new(:rook, :white, :f4, 5)
        it "returns true for f4d4" do
          expect(board.legal_rook_move?('f4d4')).to eql(true)
        end
        it "returns false f4e5" do
          expect(board.legal_rook_move?('f4e5')).to eql(false)
        end
        it "returns true for f4f7" do
          expect(board.legal_rook_move?('f4f7')).to eql(true)
        end
        it "returns false for f4f2" do
          expect(board.legal_rook_move?('f4f2')).to eql(false)
        end
      end
    end
    context ":black" do
      context ":c4" do
        board = Board.new
        board.board_hash[:c4] = Piece.new(:rook, :black, :c4, 5)
        it "returns true for c4c2" do
          expect(board.legal_rook_move?('c4c2')).to eql(true)
        end
        it "returns false for c4c7" do
          expect(board.legal_rook_move?('c4c7')).to eql(false)
        end
      end
    end
  end

  describe "#array_of_legal_knight_moves" do
    context "new board" do
      context ":white" do
        context "b1" do
          it "returns ['b1a3', 'b1c3']" do
            expect(@board.array_of_legal_knight_moves(:b1)).to eql(['b1a3', 'b1c3'])
          end
        end
        context "knight at d5" do
          board = Board.new
          board.board_hash[:d5] = Piece.new(:knight, :white, :d5, 5)
          it "returns ['d5c7', 'd5e7', 'd5f6', 'd5f4', 'd5e3', 'd5c3', 'd5b4', 'd5b6']" do
            expect(board.array_of_legal_knight_moves(:d5)).to eql(['d5c7', 'd5e7', 'd5f6', 'd5f4', 'd5e3', 'd5c3', 'd5b4', 'd5b6'].sort!)
          end
        end
      end
    end
  end

  describe "#legal_knight_move?" do
    context ":white knight to open space" do
      it "returns true" do
        expect(@board.legal_knight_move?('b1a3')).to eql(true)
      end
    end
    context ":white knight to black piece" do
      board = Board.new
      board.board_hash[:e5] = Piece.new(:knight, :white, :e5, 5)
      it "returns true" do
        expect(board.legal_knight_move?('e5f7')).to eql(true)
      end
    end
    context ":white knight to white piece" do
      it "returns false" do
        expect(@board.legal_knight_move?('b1d2')).to eql(false)
      end
    end
    context ":black knight to open space" do
      it "returns true" do
        expect(@board.legal_knight_move?('b8a6')).to eql(true)
      end
    end
    context ":black knight to white piece" do
      board = Board.new
      board.board_hash[:e4] = Piece.new(:knight, :black, :e4, 15)
      it "returns true" do
        expect(board.legal_knight_move?('e4f2')).to eql(true)
      end
    end
    context ":black knight to black piece" do
      it "returns false" do
        expect(@board.legal_knight_move?('b8d7')).to eql(false)
      end
    end
  end

  describe "#array_of_legal_queen_moves" do
    context "queen has no moves" do
      it "returns []" do
        expect(@board.array_of_legal_queen_moves(:d1)).to eql([])
      end
    end
    context "white queen at e4" do
      board = Board.new
      board.board_hash[:e4] = Piece.new(:queen, :white, :e4, 42)
      it "returns ['e4a4', 'e4b4', 'e4c4', 'e4d4', 'e4f4', 'e4g4', 'e4h4', 'e4e3', 'e4e5', 'e4e6', 'e4e7', 'e4b7', 'e4c6', 'e4d5', 'e4f3', 'e4d3', 'e4f5', 'e4g6', 'e4h7']" do
        expect(board.array_of_legal_queen_moves(:e4)).to eql(['e4a4', 'e4b4', 'e4c4', 'e4d4', 'e4f4', 'e4g4', 'e4h4', 'e4e3', 'e4e5', 'e4e6', 'e4e7', 'e4b7', 'e4c6', 'e4d5', 'e4f3', 'e4d3', 'e4f5', 'e4g6', 'e4h7'].sort!)
      end
    end
    context "black queen at e4" do
      board = Board.new
      board.board_hash[:e4] = Piece.new(:queen, :black, :e4, 43)
      it "returns ['e4a4', 'e4b4', 'e4c4', 'e4d4', 'e4f4', 'e4g4', 'e4h4', 'e4e3', 'e4e5', 'e4e6', 'e4e2', 'e4c2', 'e4c6', 'e4d5', 'e4f3', 'e4d3', 'e4f5', 'e4g6', 'e4g2']" do
        expect(board.array_of_legal_queen_moves(:e4)).to eql(['e4a4', 'e4b4', 'e4c4', 'e4d4', 'e4f4', 'e4g4', 'e4h4', 'e4e3', 'e4e5', 'e4e6', 'e4e2', 'e4c2', 'e4c6', 'e4d5', 'e4f3', 'e4d3', 'e4f5', 'e4g6', 'e4g2'].sort!)
      end
    end
  end
  describe "#legal_queen_move?" do
    context "white queen" do
      context "queen has no moves" do
        it "returns false" do
          expect(@board.legal_queen_move?('d1e1')).to eql(false)
        end
      end
      context "tries to take black piece" do
        board = Board.new
        board.board_hash[:d2] = Piece.new(:queen, :black, :d2, 0)
        it "returns false" do
          expect(board.legal_queen_move?('d1d2')).to eql(true)
        end
      end
      context "tries to jump piece" do
        board = Board.new
        board.board_hash[:d1] = Piece.new(:queen, :black, :d1, 0)
        it "returns false" do
          expect(board.legal_queen_move?('d1d3')).to eql(false)
        end
      end
      context "tries to take own piece"
    end
    context "black queen" do
      context "queen has no moves" do
        it "returns false" do
          expect(@board.legal_queen_move?('d8a5')).to eql(false)
        end
      end
      context "tries to take white piece" do
        it "returns true" do
          board = Board.new
          board.board_hash[:d1] = Piece.new(:queen, :black, :d1, 5)
          expect(board.legal_queen_move?('d1d2')).to eql(true)
        end
      end
      context "tries to jump piece" do
        it "returns false" do
          expect(@board.legal_queen_move?('d8d6')).to eql(false)
        end
      end
      context "tries to take own piece" do
        it "returns false" do
          expect(@board.legal_queen_move?('d8e8')).to eql(false)
        end
      end
    end
  end

  describe "#array_of_legal_bishop_moves" do
    context "white" do
      context "no moves" do
        it "returns []" do
          expect(@board.array_of_legal_bishop_moves(:c1)).to eql([])
        end
      end
      context ":f4" do
        board = Board.new
        board.board_hash[:f4] = Piece.new(:bishop, :white, :f4, 5)
        it "returns ['f4c7', 'f4d6', 'f4e5', 'f4g3', 'f4e3', 'f4g5', 'f4h6']" do
          expect(board.array_of_legal_bishop_moves(:f4)).to eql(['f4c7', 'f4d6', 'f4e5', 'f4g3', 'f4e3', 'f4g5', 'f4h6'].sort!)
        end
      end
    end
    context "black" do
      context "no moves" do
        it "returns []" do
          expect(@board.array_of_legal_bishop_moves(:c8)).to eql([])
        end
      end
      context ":e4" do
        board = Board.new
        board.board_hash[:e4] = Piece.new(:bishop, :black, :e4, 5)
        it "returns ['e4c2', 'e4d3', 'e4f5', 'e4g6', 'e4h7', 'e4f3', 'e4d5', 'e4c6']" do
          expect(board.array_of_legal_bishop_moves(:e4)).to eql(['e4c2', 'e4d3', 'e4f5', 'e4g6', 'e4g2', 'e4f3', 'e4d5', 'e4c6'].sort!)
        end
      end
    end
  end

  describe "#legal_bishop_move?" do
    context "new board" do
      context "c1e4" do
        it "returns false" do
          expect(@board.legal_bishop_move?('c1e4')).to eql(false)
        end
      end
      context "c1d2" do
        it "returns false" do
          expect(@board.legal_bishop_move?('c1d2')).to eql(false)
        end
      end
    end
    context "black bishop take white pawn" do
      board = Board.new
      board.board_hash[:f4] = Piece.new(:bishop, :black, :f4, 2)
      it "returns true" do
        expect(board.legal_bishop_move?('f4d2')).to eql(true)
      end
    end
    context "move horizontally" do
      board = Board.new
      board.board_hash[:f4] = Piece.new(:bishop, :black, :f4, 2)
      it "returns false" do
        expect(board.legal_bishop_move?('f4e4')).to eql(false)
      end
    end
  end

  describe "#array_of_legal_king_moves" do
    context "no moves" do
      it "returns []" do
        expect(@board.array_of_legal_king_moves(:e1)).to eql([])
      end
    end
    context "white" do
      context "d6" do
        board = Board.new
        board.board_hash[:d6] = Piece.new(:king, :white, :d5, 5)
        it "returns ['d6c7', 'd6e7', 'd6c6', 'd6c5', 'd6d5', 'd6e5', 'd6e6', 'd6d7']" do
          expect(board.array_of_legal_king_moves(:d6)).to eql(['d6c7', 'd6e7', 'd6c6', 'd6c5', 'd6d5', 'd6e5', 'd6e6', 'd6d7'].sort!)
        end
      end
      context "black" do
        context "a6" do
          board = Board.new
          board.board_hash[:a6] = Piece.new(:king, :black, :a6, 5)
          it "returns ['a6a5', 'a6b5', 'a6b6']" do
            expect(board.array_of_legal_king_moves(:a6)).to eql(['a6a5', 'a6b5', 'a6b6'].sort!)
          end
        end
      end
    end
  end

  describe "#legal_king_move?" do
    context "white" do
      context "no move" do
        it "returns false" do
          expect(@board.legal_king_move?('e1h8')).to eql(false)
        end
      end
      context "take a black piece" do
        board = Board.new
        board.board_hash[:h6] = Piece.new(:king, :white, :h6, 4)
        it "returns true" do
          expect(board.legal_king_move?('h6h7')).to eql(true)
        end
      end
      context "take white piece" do
        it "returns false" do
          expect(@board.legal_king_move?('e1d1')).to eql(false)
        end
      end
    end
    context "black" do
      context "no move" do
        it "returns false" do
          expect(@board.legal_king_move?('e8a1')).to eql(false)
        end
      end
      context "take white piece" do
        board = Board.new
        board.board_hash[:e3] = Piece.new(:king, :black, :e3, 5)
        it "returns true" do
          expect(board.legal_king_move?('e3e2')).to eql(true)
        end
      end
      context "take black piece" do
        it "returns false" do
          expect(@board.legal_king_move?('e8f8')).to eql(false)
        end
      end
    end
  end

  describe "#legal?" do
    context "new board" do
      context "tries to move piece that isn't there" do
        it "returns false" do
          expect(@board.legal?('d4a1')).to eql(false)
        end
      end
    end
    context "various legal moves" do
      it "returns true if the move is legal" do
        expect(@board.legal?('h2h4')).to eql(true)
      end
    end
  end
end