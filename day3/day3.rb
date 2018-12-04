grid = Array.new(1000) {Array.new(1000, 0)}

exp = /@\s*(\d*),(\d*):\s*(\d*)x(\d*)/

STDIN.each_line do |line|
    m = exp.match(line)
    left = m[1].to_i
    top = m[2].to_i
    width = m[3].to_i
    height = m[4].to_i

    for i in left..(left + width - 1) do
        for j in top..(top + height - 1) do
            grid[i][j] = grid[i][j] + 1
        end
    end
end

count = 0

grid.each do |inner|
    inner.each do |n|
        if n > 1 then
            count = count + 1
        end
    end
end

puts count