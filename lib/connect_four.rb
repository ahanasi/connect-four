require_relative "player.rb"
require_relative "grid.rb"

class ConnectFour
  attr_accessor :grid, :player_1, :player_2

  def initialize(grid, player_1, player_2)
    @grid = grid
    @player_1 = player_1
    @player_2 = player_2
  end

  def play_round(player)
    puts "\n#{player.name}, choose a column to drop your marker through."
    while 1
      begin
        player.position = Kernel.gets.chomp.match(/^[1-7]$/)[0].to_i
      rescue NoMethodError
        puts "Please choose a column from the grid"
      else
        until @grid.column_not_full(player.position)
          puts "Please choose a different column"
          player.position = Kernel.gets.chomp.match(/^[1-7]$/)[0].to_i
        end
        break
      end
    end

    @grid.place_disc(player.marker, player.position)
    @grid.display_grid
  end

  def self.driver()
    is_player2 = false

    puts "Welcome to Connect Four!"
    puts "Player 1, identify yourself!"
    player_1 = Player.new(gets.chomp, "🔴")

    puts "Player 2, please enter your name: "
    player_2 = Player.new(gets.chomp, "⬜")

    game = ConnectFour.new(Grid.new(), player_1, player_2)

    game.grid.display_grid()

    until (game.grid.victory_condition())
      player = is_player2 ? player_2 : player_1
      game.play_round(player)
      is_player2 = !is_player2
    end

    puts "#{player.name} wins!"
  end
end

ConnectFour.driver()
