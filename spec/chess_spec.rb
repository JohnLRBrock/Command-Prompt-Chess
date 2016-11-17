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
end