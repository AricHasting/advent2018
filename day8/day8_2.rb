class Read
    attr_accessor :e, :id
    def initialize(e, id)
        @e = e
        @id = id
    end
end

class Node
    attr_accessor :meta, :children
    def initialize()
        @meta = []
        @children = []
    end

    def value()
        v = 0

        if children.size == 0 then
            v = @meta.sum
        else
            @meta.each do |m|
                if children[m-1] then
                    v = v + children[m-1].value
                end
            end
        end

        return v
    end
end

nums = gets.split(' ').map {|s| s.to_i}
stack = []
nodes = {}
sum = 0
id = 1

first = [nums.shift, nums.shift]

first[1].times {stack << Read.new(:meta, id)}
first[0].times {stack << Read.new(:header, id)}

nodes[id] = Node.new()

while stack.size > 0 do
    read = stack.pop

    if read.e == :header then
        id = id + 1
        node = Node.new()
        nodes[id] = node
        nodes[read.id].children << node

        h = [nums.shift, nums.shift]
        h[1].times {stack << Read.new(:meta, id)}
        h[0].times {stack << Read.new(:header, id)}
    else
        n = nums.shift
        nodes[read.id].meta << n
    end
end

puts nodes[1].value