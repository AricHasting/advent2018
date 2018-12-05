line = gets.chomp

curr = 0
copied = ""
changed = true

while changed do
    copied = ""
    changed = false
    while curr < line.size do
        if curr < line.size - 1 and line[curr].upcase == line[curr+1].upcase and line[curr] != line[curr+1] then
            # line[curr] and line[curr+1] destroy each other
            curr = curr + 2
            changed = true
        else
            copied << line[curr]
            curr = curr + 1
        end
    end
    line = copied
    curr = 0
end

puts copied.size