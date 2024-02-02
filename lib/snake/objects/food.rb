require "./lib/snake/objects/types"
require "./lib/snake/objects/object"

module Snake
  module Objects
    class Food < Object
      def initialize
        super(Types::FOOD, "*")
      end
    end
  end
end
