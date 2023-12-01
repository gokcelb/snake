require "./lib/snake/map"
require "./lib/snake/player"
require "io/console"

module Snake
  class Game
    def play
      loop do
        player_input = $stdin.getch
        case player_input
        when "w"
          move_player(Direction::UP)
        when "a"
          move_player(Direction::LEFT)
        when "s"
          move_player(Direction::DOWN)
        when "d"
          move_player(Direction::RIGHT)
        when "q"
          break
        end
      end
    end

    def create_map(height, width, with_visible_borders: false)
      @grid = Map::Grid.new(height, width)
      @grid.create_borders("|", "-") if with_visible_borders
      @grid.render
    end

    def add_player(x = @grid.width / 2, y = @grid.height / 2)
      @player = Player::Snake.new(x, y, "-", "|")
      @grid.update_tile_representation(x, y, @player.head.representation)
      @grid.render
    end

    def add_food_to_random_position
      x = Random.rand(1..@grid.width)
      y = Random.rand(1..@grid.height)
      food_representation = "*"

      @grid.update_tile_representation(x, y, food_representation)
      @grid.render
    end

    def move_player(direction)
      @grid.update_tile_representation(@player.tail.x, @player.tail.y, " ")

      @player.move(direction)

      @grid.update_tile_representation(@player.head.x, @player.head.y, @player.head.representation)
      @grid.render
    end
  end
end
