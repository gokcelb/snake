require "./lib/snake/objects/types"

module Snake
  module Objects
    class Food
      attr_reader :visual, :type

      def initialize
        @visual = "*"
        @type = Types::FOOD
      end
    end
  end
end
