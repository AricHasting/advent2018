nums = gets.split(' ').map {|s| s.to_i}
stack = []
sum = 0

first = [nums.shift, nums.shift]

first[1].times {stack << :meta}
first[0].times {stack << :header}

while stack.size > 0 do
    event = stack.pop

    if event == :header then
        h = [nums.shift, nums.shift]
        h[1].times {stack << :meta}
        h[0].times {stack << :header}
    else
        n = nums.shift
        sum = sum + n
    end
end

puts sum