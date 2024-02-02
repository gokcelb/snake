require "./lib/snake/objects/types"
require "./lib/snake/objects/object"
require "./lib/snake/direction"

module Snake
  module Objects
    class Snake
      attr_reader :nodes

      def initialize
        @nodes = [SnakeNode.new(Direction::RIGHT)]
      end

      def head
        nodes.first
      end
    end

    class SnakeNode < Object
      attr_reader :direction

      def initialize(direction)
        super(Types::SNAKE, visual_by_direction)
        @direction = direction
      end

      def direction=(direction)
        @direction = direction
        @visual = visual_by_direction
      end

      private

      def visual_by_direction
        ((direction == Direction::UP) || (direction == Direction::DOWN)) ? "|" : "-"
      end
    end
  end
end
