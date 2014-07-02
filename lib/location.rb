class GridLocation
  attr_reader :x, :y, :cell

  def initialize(x, y, cell = Cell.new)
    @x = x
    @y = y
    @cell = cell
  end

  def neighbors
    @neighbors ||= neighbor_locations
  end

  def ==(other)
    self.x == other.x &&
      self.y == other.y
  end

  def tick
    alive = neighbors.select { |location| location.cell.alive? }
    cell.tick(alive.count)
  end

  def change
    cell.change
  end

  def set_neighbors(world)
    @neighbors = merge_neighbors(world)
  end

  private

  def merge_neighbors(world)
    neighbor_locations.map do |neighbor|
      if match = world.find { |location| location == neighbor }
        match
      else
        neighbor
      end
    end
  end

  def neighbor_locations
    [
      left,
      right,
      bottom,
      top,
      top_left,
      top_right,
      bottom_left,
      bottom_right
    ]
  end

  def location_at(x, y)
    GridLocation.new(x, y)
  end

  def left
    location_at(x - 1, y)
  end

  def right
    location_at(x + 1, y)
  end

  def top
    location_at(x, y + 1)
  end

  def bottom
    location_at(x, y - 1)
  end

  def top_left
    location_at(x - 1, y + 1)
  end

  def top_right
    location_at(x + 1, y + 1)
  end

  def bottom_left
    location_at(x - 1, y - 1)
  end

  def bottom_right
    location_at(x + 1, y - 1)
  end
end
