require "pry"

class Grid
  attr_accessor :grid
  ROWS = ("1".."6").to_a
  COLS = ("1".."7").to_a
  MARKERS = ["🔴", "⬜"]

  def initialize
    @grid = Array.new(6, ".").map { |row| Array.new(7, ".") }
  end

  def display_grid()
    print "\t"
    print COLS.join("\t")
    puts
    @grid.each_with_index do |row, i|
      puts ("\n")
      print ROWS[i]
      print "\t"
      print row.join("\t")
      puts
    end
  end

  def place_disc(marker, column)
    @grid.to_enum.with_index.reverse_each do |row, idx|
      next if is_occupied?([idx, column - 1])
      return @grid[idx][column - 1] = marker
    end
  end

  def victory_condition
    # Four in a row
    return true if quartet_check(@grid)

    # Four in a column
    return true if quartet_check(@grid.transpose)

    #Four in a diagonal
    return true if quartet_check(get_diagonals(@grid))

    #Four in anti-diagonal
    return true if quartet_check(get_diagonals(rotate_array(@grid)))

    return false
  end

  private

  def is_occupied?(position)
    MARKERS.any? { |marker| @grid[position[0]][position[1]] == marker }
  end

  def quartet_check(arr)
    arr.each do |row|
      row.each_cons(4).to_a.each do |quartet|
        if quartet.all? { |val| val == MARKERS[0] } || quartet.all? { |val| val == MARKERS[1] }
          return true
        end
      end
    end
    return false
  end

  def get_diagonals(matrix)
    return (0..matrix.size - 4).map { |row| (0..matrix.size - 1 - row).map { |col| matrix[row + col][col] } }.concat(
             (1..matrix.first.size - 4).map { |col| (0..matrix.first.size - 1 - col).map { |row| matrix[row][col + row] } }
           )
  end

  def rotate_array(arr)
    rotated = []
    arr.transpose.each { |row| rotated << row.reverse }
    return rotated
  end
end
