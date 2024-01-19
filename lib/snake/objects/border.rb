require "./lib/snake/objects/types"

module Snake
  module Objects
    class Border
      attr_reader :visual, :type

      def initialize(direction)
        @visual = direction == 'horizontal' ? "-" : "|"
        @type = Types::BORDER
      end
    end
  end
end
