require "./lib/snake/direction"

module Snake
  module Player
    class Node
      attr_reader :x, :y, :horizontal_rep, :vertical_rep, :direction

      def initialize(x, y, horizontal_rep, vertical_rep, direction)
        @x = x
        @y = y
        @horizontal_rep = horizontal_rep
        @vertical_rep = vertical_rep
        @direction = direction
      end

      def representation
        (@direction == Direction::UP || @direction == Direction::DOWN) ? vertical_rep : horizontal_rep
      end
    end
  end
end