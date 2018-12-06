class Point
    attr_accessor :x, :y
    def initialize(x, y)
        @x = x
        @y = y
    end

    def distance(other)
        return (@x - other.x).abs + (@y - other.y).abs
    end

    def format()
        return "#{x}, #{y}"
    end
end

# Read in all points
points = []
STDIN.each_line do |line|
    line = line.split(',')
    points.push(Point.new(line[0].to_i, line[1].to_i))
end

# Find bounds of grid
right = points.max_by {|point| point.x}
bottom = points.max_by {|point| point.y}

grid = Array.new(right.x) {Array.new(bottom.y)}
DEFAULT = Point.new(-1, -1)

# Count points within a total of 10k distance
count = 0
for x in 0..grid.size-1 do
    for y in 0..grid[x].size-1 do
        grid[x][y] = Point.new(x, y)
        total = (points.map {|point| point.distance(grid[x][y])}).sum
        if total < 10000 then
            count = count + 1
        end
    end
end

puts count