require "./lib/snake/map/tile"
require "./lib/snake/direction"

module Snake
  class Player
    attr_reader :x, :y, :representation, :direction

    def initialize(x, y)
      @x = x
      @y = y
      @representation = "-"
      @direction = Direction::LEFT
    end

    def move_up(by = 1)
      @direction = Direction::UP
      @representation = representation_by_direction
      @y -= 1
    end

    def move_down(by = 1)
      @direction = Direction::DOWN
      @representation = representation_by_direction
      @y += 1
    end

    def move_right(by = 1)
      @direction = Direction::RIGHT
      @representation = representation_by_direction
      @x += 1
    end

    def move_left(by = 1)
      @direction = Direction::LEFT
      @representation = representation_by_direction
      @x -= 1
    end

    private

    def representation_by_direction
      (@direction == Direction::UP || @direction == Direction::DOWN) ? "|" : "-"
    end
  end
end
