module Snake
  module Objects
    class Object
      attr_accessor :position
      attr_reader :type, :visual

      def initialize(type, visual)
        @position = nil
        @type = type
        @visual = visual
      end
    end
  end
end
