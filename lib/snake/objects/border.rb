module Snake
  module Objects
    class Border
      attr_reader :visual, :type

      def initialize(visual)
        @visual = visual
        @type = "border"
      end
    end
  end
end
