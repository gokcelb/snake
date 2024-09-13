require "./lib/snake/map"
require "io/console"
require "./lib/snake/direction"
require "./lib/snake/spawner"

module Snake
  class Game
    def play
      loop do
        @food_spawner.spawn
        player_input = $stdin.getch
        case player_input
        when "w"
          handle_move_snake(Direction::UP)
        when "a"
          handle_move_snake(Direction::LEFT)
        when "s"
          handle_move_snake(Direction::DOWN)
        when "d"
          handle_move_snake(Direction::RIGHT)
        when "q"
          break
        end
      end
    end

    def create_map(height, width, with_visible_borders: false)
      @map = Map.new(height, width)
      @map.create_borders("|", "-") if with_visible_borders
      @map
    end

    def create_food_spawner
      @food_spawner = Snake::Spawner.new(@map, Snake::Objects::Food)
    end

    def handle_move_snake(headed_direction)
      new_index = @map.new_index_from(headed_direction, @snake.head.position)
      collided_object_type = @map.detect_collision(new_index)

      if collided_object_type.nil?
        return move_snake(headed_direction)
      end

      if collided_object_type != Objects::Types::FOOD
        raise 'collided object other than food'
      end

      @map.clear(new_index)
      @snake.grow
      @map.update(new_index, @snake.head, headed_direction)
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
      new_index = @map.new_index_from(direction, object.position)
      @map.clear(object.position)
      @map.update(new_index, object, direction)
    end

    def add_snake
      @snake = Objects::Snake.new
      object = @snake.head
      index = @map.random_position
      collided_object_type = @map.detect_collision(index)
      until collided_object_type.nil? do
        index = @map.random_position
        collided_object_type = @map.detect_collision(index)
      end
      @map.update(index, object)
    end
  end
end
