require "./lib/snake/player/node"
require "./lib/snake/direction"

module Snake
  module Player
    class Snake
      attr_reader :nodes

      def initialize(x, y, horizontal_rep, vertical_rep)
        @horizontal_rep = horizontal_rep
        @vertical_rep = vertical_rep

        @nodes = [Node.new(x, y, @horizontal_rep, @vertical_rep, Direction::RIGHT)]
      end

      def grow
        direction = head.direction
        diff = coord_diff_by_direction(direction)
        new_node = Node.new(
          head.x + diff[0],
          head.y + diff[1],
          @horizontal_rep,
          @vertical_rep,
          direction,
        )

        @nodes.push(new_node)
      end

      def move(direction)
        coord_diff = coord_diff_by_direction(direction)
        new_head = Node.new(
          head.x + coord_diff.first,
          head.y + coord_diff.last,
          @horizontal_rep,
          @vertical_rep,
          direction
        )

        @nodes.unshift(new_head)
        @nodes.pop
      end

      def head
        @nodes.first
      end

      def tail
        @nodes.last
      end

      private

      def coord_diff_by_direction(direction)
        case direction
        when Direction::UP
          [0, -1]
        when Direction::DOWN
          [0, 1]
        when Direction::RIGHT
          [1, 0]
        when Direction::LEFT
          [-1, 0]
        else
          [0 , 0]
        end
      end
    end
  end
end