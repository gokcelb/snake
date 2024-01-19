require "./lib/snake/objects"

module Snake
  class Map
    class CollisionError < StandardError
      attr_reader :object_type

      def initialize(object_type)
        @object_type = object_type
      end
    end

    attr_reader :height, :width, :tiles

    def initialize(height, width)
      @width = width
      @height = height
      @objects = Array.new(width * height)
    end

    def create_borders(vertical_representation, horizontal_representation)
      render do
        @objects.each_with_index do |_, index|
          if on_horizontal_edge?(index)
            @objects[index] = Objects::Border.new("horizontal")
          end

          if @objects[index].nil? && on_vertical_edge?(index)
            @objects[index] = Objects::Border.new("vertical")
          end
        end
      end
    end

    def update(index, object)
      render do
        raise CollisionError.new(@objects[index].type) unless @objects[index].nil?

        @objects[index] = object
      end
    end

    def on_horizontal_edge?(index)
      index.between?(0, @width - 1) || index.between?(@width * (@height - 1), @width * @height - 1)
    end

    def on_vertical_edge?(index)
      index % width == 0 || end_of_row?(index)
    end

    def end_of_row?(index)
      (index + 1) % width == 0
    end

    private

    def render(&block)
      block.call

      system("clear")
      @objects.each_with_index do |object, index|
        object.nil? ? print(" ") : print(object.visual)
        print "\n" if end_of_row?(index)
      end
    end
  end
end
