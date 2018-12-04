require 'date'

lines = []
STDIN.each_line do |line|
    lines.push(line)
end

# Sorts lines in chronological order, technically
lines = lines.sort

shift_regex = /Guard #(\d*)/
wake_regex = /wakes up/
sleep_regex = /falls asleep/
time_regex = /\[.*:(\d\d)\]/

guards = {}
current = nil
sleep_time = nil

lines.each do |event|
    em = event.match(shift_regex)
    if em then
        if not guards.key?(em[1]) then
            guards[em[1]] = Array.new(60, 0)
        end

        current = em[1]
        next
    end

    em = event.match(sleep_regex)
    if em then
        sleep_time = event.match(time_regex)[1].to_i
        next
    end

    em = event.match(wake_regex)
    if em then
        wake_time = event.match(time_regex)[1].to_i
        g = guards[current]
        for i in sleep_time..(wake_time - 1) do
            g[i] = g[i] + 1
        end
    end
end

max_guard = (guards.max_by {|k, v| v.max})[0]

max_minute = guards[max_guard].each_with_index.max[1]

puts max_guard.to_i * max_minute