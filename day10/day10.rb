class Particle
    attr_accessor :pos, :dir
    def initialize(pos, dir)
        @pos = pos
        @dir = dir
    end

    def update
        pos.x += dir.x
        pos.y += dir.y
    end

    def inspect
        return "<#{pos.x}, #{pos.y}> @ <#{dir.x}, #{dir.y}>"
    end
end

class Point
    attr_accessor :x, :y
    def initialize(x, y)
        @x = x
        @y = y
    end
end

stars = STDIN.map do |l|
    s = l.scan(/[\-\d]+/)
    Particle.new(Point.new(s[0].to_i, s[1].to_i), Point.new(s[2].to_i, s[3].to_i))
end

for i in 0..20000 do
    left = stars.min_by {|s| s.pos.x}.pos.x
    right = stars.max_by {|s| s.pos.x}.pos.x
    top = stars.min_by {|s| s.pos.y}.pos.y
    bottom = stars.max_by {|s| s.pos.y}.pos.y

    if right - left < 62 and bottom - top < 10 then
        puts "Found at #{i} seconds."
        output = ""
        for y in top..bottom do
            for x in left..right do
                if stars.any? {|s| s.pos.x == x and s.pos.y == y} then
                    output << "#"
                else
                    output << "."
                end
            end
            output << "\n"
        end
        print output
        return
    end

    stars.each do |s|
        s.update
    end
end