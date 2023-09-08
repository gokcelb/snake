require "./lib/snake/map"
require "./lib/snake/player"

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
      @player = Player.new(x, y)
      @grid.update_tile_representation(x, y, @player.representation)
      @grid.render
    end

    def move_player(direction, by = 1)
      @grid.update_tile_representation(@player.x, @player.y, " ")

      case direction
      when Direction::UP
        @player.move_up(by)
      when Direction::DOWN
        @player.move_down(by)
      when Direction::RIGHT
        @player.move_right(by)
      when Direction::LEFT
        @player.move_left(by)
      end

      @grid.update_tile_representation(@player.x, @player.y, @player.representation)
      @grid.render
    end
  end
end
