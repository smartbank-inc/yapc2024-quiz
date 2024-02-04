original_code = File.read(File.expand_path('../original_client.rb', __FILE__))
code = 'eval(%w(' + original_code.tr(32.chr, "$").tr("\n", ";")
aa = `ruby #{File.expand_path('../aa_generator.rb', __FILE__)} YAPC2024 60`

width = aa.index("\n")

result_aa = ''
n = 4
0.upto(n) do |i|
  result_aa << code[width*i...width*(i+1)] + "\n"
end
result_aa += "\n"

i = width * (n+1)
aa.chars.each do |c|
  if c == '#' && code[i]
    result_aa += code[i]
    i += 1
  else
    result_aa += c
  end
end

result_aa += "\n"
result_aa += code[i..].scan(/.{1,#{width}}/m).join("\n")
result_aa += ').join.tr("$", 32.chr))'

File.write(File.expand_path('../../client/client.rb', __FILE__), result_aa)
