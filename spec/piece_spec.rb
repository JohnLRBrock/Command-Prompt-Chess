require 'piece'

describe Piece do
  before(:each) do
    @piece = Piece.new(:queen, :white, :a1)
  end
  it "responds to #type" do
    expect(@piece).to respond_to(:type)
  end
  it "responds to #player" do
    expect(@piece).to respond_to(:player)
  end
  it "responds to #location" do
    expect(@piece).to respond_to(:location)
  end
  it "responds to #moved" do
    expect(@piece).to respond_to(:moved)
  end
  it "responds to #last_moved_on" do
    expect(@piece).to respond_to(:last_moved_on)
  end
end