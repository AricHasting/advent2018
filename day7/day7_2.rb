class Node
    attr_accessor :name, :before, :visited, :started
    def initialize(name)
        @name = name
        @visited = false
        @started = false
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

class Job
    attr_accessor :node, :finish
    def initialize(node, finish)
        @node = node
        @finish = finish
    end
end

def select_node(nodes)
    available = nodes.select {|n| n.available? and not n.visited and not n.started}
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

jobs = []
time = 0

while nodes.any? {|n| not n.visited} do
    while jobs.size < 5 and (s = select_node(nodes)) != nil do
        finish = time + s.name.ord - 4
        jobs << Job.new(s, finish)
        s.started = true
    end

    first = jobs.min_by {|j| j.finish}
    first.node.visited = true
    time = first.finish
    jobs.delete(first)
end

puts time