require "./lib/snake/objects/types"
require "./lib/snake/objects/object"

module Snake
  module Objects
    class Border < Object
      def initialize(direction)
        super(Types::BORDER, (direction == "horizontal") ? "-" : "|")
      end
    end
  end
end
