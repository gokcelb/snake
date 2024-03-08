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
            horizontal_border = Objects::Border.new("horizontal")
            @objects[index] = horizontal_border
            horizontal_border.position = index
          end

          if @objects[index].nil? && on_vertical_edge?(index)
            vertical_border = Objects::Border.new("vertical")
            @objects[index] = vertical_border
            vertical_border.position = index
          end
        end
      end
    end

    def detect_collision(index)
      @objects[index].type unless @objects[index].nil?
    end

    def update(index, object, direction = nil)
      render do
        raise CollisionError.new(@objects[index].type) unless @objects[index].nil?

        @objects[index] = object
        object.position = index
        object.direction = direction unless direction.nil?
      end
    end

    def clear(index)
      render do
        object = @objects[index]
        object.position = nil
        @objects[index] = nil
      end
    end

    def new_index_from(headed_direction, current_index)
      delta_from(headed_direction) => {horizontal_delta:, vertical_delta:}
      new_column = column_number_from(current_index) + horizontal_delta
      new_row = row_number_from(current_index) + vertical_delta
      index_from(new_row, new_column)
    end

    private

    def row_number_from(index)
      (index / width) + 1
    end

    def column_number_from(index)
      (index % width) + 1
    end

    def index_from(row_number, column_number)
      ((row_number - 1) * width) + (column_number - 1)
    end

    def delta_from(direction)
      case direction
      when Direction::RIGHT
        {horizontal_delta: 1, vertical_delta: 0}
      when Direction::LEFT
        {horizontal_delta: -1, vertical_delta: 0}
      when Direction::UP
        {horizontal_delta: 0, vertical_delta: -1}
      when Direction::DOWN
        {horizontal_delta: 0, vertical_delta: 1}
      else
        {horizontal_delta: 0, vertical_delta: 0}
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
