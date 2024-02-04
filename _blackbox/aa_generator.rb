# Just a little script to generate ASCII art from a string

if ARGV.length < 1
  puts 'Usage: ruby aa_generator.rb STRING [HEIGHT]'
  exit
end

string = ARGV[0]
height = ARGV[1] || 60

# It works on macOS only
puts `banner -w #{height} #{string}`.
  lines.
  map{_1.chomp.ljust(height.to_i)}
  .map{_1.tr('# ', '+-').chars}.
  transpose.
  map(&:join).
  reverse.
  map{_1.tr('+-', '# ')}.
  map(&:chomp).
  reject{_1.strip.empty?}.
  join("\n")
