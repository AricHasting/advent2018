class Point
    attr_accessor :x, :y, :closest, :infinite
    def initialize(x, y)
        @x = x
        @y = y
        @closest = nil
        @infinite = false
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
# left = points.min_by {|point| point.x}
right = points.max_by {|point| point.x}
# top = points.min_by {|point| point.y}
bottom = points.max_by {|point| point.y}

grid = Array.new(right.x) {Array.new(bottom.y)}
DEFAULT = Point.new(-1, -1)

# Find all closest points in the field. Set as DEFAULT for equidistant points.
for x in 0..grid.size-1 do
    for y in 0..grid[x].size-1 do
        grid[x][y] = Point.new(x, y)
        closest = points.min_by {|point| point.distance(grid[x][y])}
        best = closest.distance(grid[x][y])
        grid[x][y].closest = closest
        points.each do |point|
            if point != closest and point.distance(grid[x][y]) == best then
                grid[x][y].closest = DEFAULT
                break
            end
        end
    end
end

# All points along the boundary expand infinitely
for x in 0..grid.size-1 do
    grid[x][0].closest.infinite = true
    grid[x][grid[0].size-1].closest.infinite = true
end

for y in 0..grid[0].size-1 do
    grid[0][y].closest.infinite = true
    grid[grid.size-1][y].closest.infinite = true
end

finite_points = points.select {|point| not point.infinite}

# Count points in the field. Slow, but easy.
def count(grid, point)
    count = 0
    grid.each do |x|
        x.each do |pnt|
            if pnt.closest == point then
                count = count + 1
            end
        end
    end
    return count
end

max_point = finite_points.max_by {|point| count(grid, point)}
puts count(grid, max_point)