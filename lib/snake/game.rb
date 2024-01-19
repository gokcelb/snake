require "./lib/snake/map"
require "./lib/snake/player"
require "io/console"

module Snake
  class Game
    def play
      loop do
        player_input = $stdin.getch
        case player_input
        when "q"
          break
        end
      end
    end

    def create_map(height, width, with_visible_borders: false)
      @map = Map.new(height, width)
      @map.create_borders("|", "-") if with_visible_borders
    end

    def add_food
      object = Objects::Food.new
      index = Random.rand(1..@map.width * @map.height)
      updated = false

      until updated
        begin
          @map.update(index, object)
          updated = true
        rescue Map::CollisionError => exception
          if exception.object_type == Object::Types::BORDER
            index = Random.rand(1..@map.width * @map.height)
          end
        end
      end
    end
  end
end
