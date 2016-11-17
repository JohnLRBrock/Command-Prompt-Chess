require 'board'

describe Board do
  before(:each) do
    @board = Board.new
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
end