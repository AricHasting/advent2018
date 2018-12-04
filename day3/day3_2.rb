class Rectangle
    attr_accessor :x, :y, :w, :h, :used
    def initialize(x, y, width, height)
        @x = x
        @y = y
        @w = width
        @h = height
        @used = false
    end

    def overlaps(other)
        if x < other.x + other.w and
            x + w > other.x and 
            y < other.y + other.h and
            y + h > other.y then
                return true
        end
        return false
    end
end

exp = /@\s*(\d*),(\d*):\s*(\d*)x(\d*)/
rect = []

STDIN.each_line do |line|
    m = exp.match(line)
    left = m[1].to_i
    top = m[2].to_i
    width = m[3].to_i
    height = m[4].to_i

    rect.push(Rectangle.new(left, top, width, height))
end

# Compare all rectangles with each other
for i in 0..(rect.length - 1) do
    for j in (i + 1)..(rect.length - 1) do
        if rect[i].overlaps(rect[j]) then
            rect[j].used = true
            rect[i].used = true
        end
    end
end

rect.each_with_index do |x, i|
    if not x.used then
        puts i + 1
    end
end