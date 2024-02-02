require "./lib/snake/map"
require "io/console"
require "./lib/snake/direction"

module Snake
  class Game
    def play
      loop do
        player_input = $stdin.getch
        case player_input
        when "w"
          move_snake(Direction::UP)
        when "a"
          move_snake(Direction::LEFT)
        when "s"
          move_snake(Direction::DOWN)
        when "d"
          move_snake(Direction::RIGHT)
        when "q"
          break
        end
      end
    end

    def create_map(height, width, with_visible_borders: false)
      @map = Map.new(height, width)
      @map.create_borders("|", "-") if with_visible_borders
    end

    def move_snake(headed_direction)
      new_directions = []
      @snake.nodes.each_with_index do |node, i|
        direction = (i == 0) ? headed_direction : @snake.nodes[i - 1].direction
        new_directions << direction
      end
      @snake.nodes.each_with_index { |node, i| move_object(node, new_directions[i]) }
    end

    def move_object(object, direction)
      @map.delta_from(direction) => {horizontal_delta:, vertical_delta:}

      column = @map.column_number_from(object.position) + horizontal_delta
      new_row = @map.row_number_from(object.position) + vertical_delta
      new_index = @map.index_from(new_row, column)

      @map.clear(object)
      @map.update(new_index, object, direction)
    end

    def add_snake
      @snake = Objects::Snake.new
      object = @snake.head
      index = Random.rand(1..@map.width * @map.height)
      updated = false

      until updated
        begin
          @map.update(index, object)
          updated = true
        rescue Map::CollisionError => exception
          if exception.object_type == Objects::Types::BORDER
            index = Random.rand(1..@map.width * @map.height)
          end
        end
      end
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
          if exception.object_type == Objects::Types::BORDER
            index = Random.rand(1..@map.width * @map.height)
          end
        end
      end
    end
  end
end
