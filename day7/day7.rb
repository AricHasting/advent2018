class Node
    attr_accessor :name, :before, :visited
    def initialize(name)
        @name = name
        @visited
        @before = []
    end

    def add_before(node)
        @before << node
    end

    def available?()
        @before.all? {|n| n.visited}
    end
end

class Edge
    attr_accessor :from, :to
    def initialize(from, to)
        @from = from
        @to = to
    end
end

def select_node(nodes)
    available = nodes.select {|n| n.available? and not n.visited}
    return available.min_by {|n| n.name}
end

# Construct edges
lines = STDIN.map {|l| /Step ([A-Z]).*step ([A-Z])/.match(l)}
edges = lines.map {|l| Edge.new(l[1], l[2])}

nodes = {}

# Construct nodes/graph from edges
edges.each do |e|
    if not nodes.key?(e.from) then
        nodes[e.from] = Node.new(e.from)
    end
    if not nodes.key?(e.to) then
        nodes[e.to] = Node.new(e.to)
    end
    nodes[e.to].add_before(nodes[e.from])
end

nodes = nodes.values
sequence = []

# Print all nodes in order of selection
for i in 0..nodes.size-1 do
    s = select_node(nodes)
    s.visited = true
    print s.name
end