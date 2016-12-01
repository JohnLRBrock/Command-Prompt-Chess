require 'piece'
require 'board'
require 'chess'

describe Chess do
  before(:each) do
    @game = Chess.new
  end
  describe "#valid_move?" do
    context "valid chess move" do
      it "returns true" do
        expect(@game.valid_move?('a1b2')).to eql(true)
      end
    end
    context "move longer than four characters" do
      it "returns false" do
        expect(@game.valid_move?('a1b2b')).to eql(false)
      end
    end
    context "move involves square above board" do
      it "returns false" do
        expect(@game.valid_move?('a9b2')).to eql(false)
      end
    end
    context "move involves square below board" do
      it "returns false" do
        expect(@game.valid_move?('a0b2')).to eql(false)
      end
    end
    context "move involves square to right of board" do
      it "returns false" do
        expect(@game.valid_move?('z1b2')).to eql(false)
      end
    end
    context "move has number at the 0th or 2nd index" do
      it "returns false" do
        expect(@game.valid_move?('1111')).to eql(false)
      end
    end
    context "move has letter at the 1st or 3rd index" do
      it "returns false" do
        expect(@game.valid_move?('aaaa')).to eql(false)
      end
    end
  end
  describe "#change_player" do
    context "white's turn" do
      game = Chess.new
      game.player = :white
      it "changes the player to :black" do
        game.change_player
        expect(game.player).to eql(:black)
      end
    end
    context "black's turn" do
      game = Chess.new
      game.player = :black
      it "changes the player to :white" do
        game.change_player
        expect(game.player).to eql(:white)
      end
    end
  end
  describe "#hint?" do
    context "a1b2" do
      it "returns false" do
        expect(@game.hint?('a1b2')).to eql(false)
      end
    end
    context "hint a1" do
      it "returns true" do
        expect(@game.hint?('hint a1')).to eql(true)
      end
    end
  end
  describe "#hint_for" do
    context ":a1" do
      it "returns 'there are no moves for a1'" do
        expect(@game.hint_for(:a1)).to eql('There are no moves for a1.')
      end
    end
    context ":f2" do
      it "returns '['f2f3', 'f2f4']'" do
        expect(@game.hint_for(:f2)).to eql(['f2f3', 'f2f4'])
      end
    end
    context ":a8" do
      it "returns 'there are no moves for a8'" do
        expect(@game.hint_for(:a8)).to eql('There are no moves for a8.')
      end
    end
    context ":f7" do
      it "returns '['f7f6', 'f7f5']'" do
        expect(@game.hint_for(:f7)).to eql(['f7f5', 'f7f6'])
      end
    end
    context ":c5" do
      it "returns 'There is no piece at c5'" do
        expect(@game.hint_for(:c5)).to eql('No piece at c5.')
      end
    end
    context "black with en passant possible at h4" do
      game = Chess.new
      game.board.turn = 3
      game.board.board_hash[:h4] = Piece.new(:pawn, :black, :h4, 3)
      game.board.board_hash[:g4] = Piece.new(:pawn, :white, :g4, 1, 2)
      game.board.board_hash[:h3] = Piece.new(:pawn, :white, :h3, 1)
      game.board.board_hash[:h2] = nil
      game.board.board_hash[:g2] = nil
      it "returns '['h4g3']'" do
        expect(game.hint_for(:h4)).to eql(['h4g3'])
      end
    end
  end
  describe "#extract_location" do
    context "'hint a1'" do
      it "returns :a1" do
        expect(@game.extract_location('hint a1')).to eql(:a1)
      end
    end
  end
end