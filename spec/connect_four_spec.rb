require "./lib/grid.rb"

describe Grid do
  describe "#place_disc" do
    it "drops disc at specified column position" do
      test = Grid.new()
      test.place_disc("🔴", 1)
      expect(test.grid[5][0]).to eql("🔴")
    end

    it "drops disc above occupied position in column" do
      test = Grid.new()
      test.place_disc("🔴", 1)
      test.place_disc("⬜", 1)
      expect(test.grid[4][0]).to eql("⬜")
    end
  end
  describe "#is_occupied?" do
    it "returns true if position is occupied by marker" do
      test = Grid.new()
      test.grid[3][3] = "🔴"
      expect(test.is_occupied?([3, 3])).to be true
      expect(test.is_occupied?([0, 0])).to be false

      test.grid[0][0] = "⬜"
      expect(test.is_occupied?([0, 0])).to be true
    end
  end

  describe "quartet_check" do
    it "returns true if 4 consecutive elements are similar" do
      test = Grid.new()
      expect(test.quartet_check([["🔴","🔴","🔴","🔴"],[".",".",".","."]])).to be true
      expect(test.quartet_check([["🔴","🔴",".","🔴",],["🔴","🔴"]])).to be false
      expect(test.quartet_check([["🔴",".","🔴","🔴","🔴","🔴"],[".","."]])).to be true
    end
  end

  describe "#victory_condition" do
    it "returns true if horizontal 4-in-a-row" do
      test = Grid.new()
      test.place_disc("⬜", 3)
      (3..6).each { |num| test.place_disc("🔴", num) }

      expect(test.victory_condition).to be false

      (4..6).each { |num| test.place_disc("🔴", num) }
      expect(test.victory_condition).to be true
    end

    it "returns true if vertical 4-in-a-row" do
      test = Grid.new()
      test.place_disc("⬜", 3)
      3.times { test.place_disc("🔴", 3) }

      expect(test.victory_condition).to be false

      test.place_disc("🔴", 3)
      expect(test.victory_condition).to be true
    end

    it "returns true if diagonal 4-in-a-row" do
      test = Grid.new()
      (0..3).each {|val| test.grid[val][val] = "🔴"}
      expect(test.victory_condition).to be true
    end

    it "returns true if anti-diagonal 4-in-a-row" do
      test = Grid.new()
      i = 0; j = 6; count = 4
      until count == 0
        test.grid[i][j] = "🔴"
        i += 1; j -= 1; count -= 1;
      end
      expect(test.victory_condition).to be true
    end

  end

  describe "#column_not_full" do
    it "returns true if the column has not been filled in all rows" do
      test = Grid.new()
      test.grid.each_with_index do |row,i|
        test.grid[i][0] = "🔴"
      end
      expect(test.column_not_full(1)).to be false
    end
  end
end
