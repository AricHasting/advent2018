require 'set'

s = Set[]
seq = STDIN.map {|l| l.to_i}

n = 0

loop do
    seq.each do |i|
        n += i
        if s === n then
            puts n
            exit
        end
        s << n
    end
end