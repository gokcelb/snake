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
      @map = Map.new(height, width)
      @map.create_borders("|", "-") if with_visible_borders
      @map.render
    end

    def add_player(x = @map.width / 2, y = @map.height / 2)
      @player = Player::Snake.new(x, y, "-", "|")
      @map.update_tile_representation(x, y, @player.head.representation)
      @map.render
    end

    def add_food_to_random_position
      x = Random.rand(1..@map.width)
      y = Random.rand(1..@map.height)
      food_representation = "*"

      @map.update_tile_representation(x, y, food_representation)
      @map.render
    end

    def move_player(direction)
      @map.update_tile_representation(@player.tail.x, @player.tail.y, " ")

      @player.move(direction)

      @map.update_tile_representation(@player.head.x, @player.head.y, @player.head.representation)
      @map.render
    end
  end
end
