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
    end

    em = event.match(sleep_regex)
    if em then
        sleep_time = event.match(time_regex)[1].to_i
    end

    em = event.match(wake_regex)
    if em then
        wake_time = event.match(time_regex)[1].to_i
        g = guards[current]
        for i in sleep_time..wake_time do
            g[i] = g[i] + 1
        end
    end
end

max = 0
m_guard = guards.keys[0]
guards.each do |k, g|
    s = g.sum
    if s > max then
        max = s
        m_guard = k
    end
end

max_minute = guards[m_guard].each_with_index.max[1]

puts m_guard.to_i * max_minute