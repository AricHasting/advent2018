class Marble
    attr_accessor :left, :right, :points

    def initialize(points)
        @left = self
        @right = self
        @points = points
    end

    def insert(value)
        old = @right
        @right = Marble.new(value)
        @right.left = self
        @right.right = old
        old.left = @right
    end

    def pop
        @left.right = @right
        @right.left = @left
        return @points
    end
end

line = gets.match(/^\D*(\d+)\D*(\d+)/)
players = Array.new(line[1].to_i, 0)
max = line[2].to_i * 100

current_player = 0
current = Marble.new(0)

for i in 1..max do
    if i % 23 == 0 then
        7.times {current = current.left}
        score = current.pop
        current = current.right
        players[current_player] += score + i
    else
        current = current.right
        current.insert(i)
        current = current.right
    end
    current_player = (current_player + 1) % players.size
end

puts players.max