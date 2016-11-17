require 'board'

describe Board do
  before(:each) do
    @board = Board.new
  end
  it "responds to #board_hash" do
    expect(@board).to respond_to(:board_hash)
  end
end