require 'net/http'
require 'csv'
require 'json'
require 'digest'
require 'base64'

API_HOST = ENV.fetch('API_HOST', 'http://localhost:3000')

begin
  Net::HTTP.post(URI("#{API_HOST}/init"), '')
rescue Errno::ECONNREFUSED
  puts 'Waiting for API server to be ready.'
  sleep 1
  retry
end

csv_data = File.read(File.expand_path('../requests.csv', __FILE__))
csv_rows = CSV.parse(csv_data, headers: true)

seen = {}
payload_violation_correct = true
csv_rows.each do |row|
  body = { amount: Integer(row['amount']), shop_name: row['shop_name'] }.to_json
  headers = { 'Content-Type': 'application/json' }
  headers['Idempotency-Key'] = row['idempotency_key'] unless row['idempotency_key'].empty?
  response = Net::HTTP.post(URI("#{API_HOST}/payments"), body, headers)

  unless row['idempotency_key'].empty?
    if seen.key?(row['idempotency_key']) && seen[row['idempotency_key']] != body && response.code != '422'
      payload_violation_correct = false
    end
    seen[row['idempotency_key']] ||= body
  end
end

response = Net::HTTP.get(URI("#{API_HOST}/summary"))
response_json = JSON.parse(response)

balance = response_json['balance']
shop_names = response_json['shop_names'].uniq.sort
digest = Digest::SHA256.hexdigest(shop_names.join)

def decode(s)
  Base64.strict_decode64(s).force_encoding('UTF-8')
end

balance_correct = balance >= 0
shop_correct = digest == 'dca44393bd149dfb6a004ff9d488302c833be68e0d655f2a65105df388f434af'
points = [balance_correct, shop_correct, payload_violation_correct].count(&:itself)
rank = ['C', 'B', 'A', 'S'][points]
rank_result = "%<rank_label>s%<rank>s" % {rank_label:decode('44CQ44Op44Oz44Kv44CR'), rank:}
cto_comment = decode('44CQQ1RP44GL44KJ44Gu5LiA6KiA44CR') + decode(['44KC44GG57WC44KP44KK44Gg4oCm', '5Yqp44GL44Gj44Gf4oCm44Gu44GL4oCm77yf', '5Yqp44GR44Gm44GP44KM44Gm44GC44KK44GM44Go44GG4oCm44GC44KK44GM44Go44GG4oCm', '44GG44Gh44Gr5YWl56S+44GX44Gm44GP44KM44Cc77yB'][points])
balance_result = decode(balance_correct ? '4pyFIENUT+OCkuegtOeUo+OBi+OCieaVkeOBhuOBk+OBqOOBjOOBp+OBjeOBn++8gfCfkrA=' : '4p2MIENUT+OBr+egtOeUo+OBl+OBpuOBl+OBvuOBo+OBny4uLvCfkrg=')
shop_result = decode(shop_correct ? '4pyFIOioquWVj+OBl+OBn+OBiuW6l+OCkuato+eiuuOBq+iomOmMsuOBp+OBjeOBn++8gfCfpbM=' : '4p2MIOioquWVj+OBl+OBn+OBiuW6l+OCkuato+eiuuOBq+iomOmMsuOBp+OBjeOBquOBi+OBo+OBny4uLvCfkpQ=')
n = decode('Cg==')
bonus_result = rank == 'S' ? decode('4pyFIOODj+ODvOODieODouODvOODieOCr+ODquOCou+8gfCfjoo=') + n : ''
post_text = "#{decode('44KP44Gf44GX44GM5q6L44GZ44GT44Go44GM44Gn44GN44GfQ1RP44Gu6LKh55Sj44Gv')}#{balance}#{decode('5YaG44Gn44GX44Gf')}#{n*2}#{rank_result}#{n}#{cto_comment}#{n*2}#{bonus_result}#{balance_result}#{n}#{shop_result}#{n*2}#{decode('I3lhcGNqYXBhbiAjQ1RP44KS56C055Sj44GL44KJ5pWR44GK44GG44OB44Oj44Os44Oz44K4IA==')}#{n}https://github.com/smartbank-inc/yapc2024-quiz"
post_url = 'https://twitter.com/intent/tweet?text=' + URI.encode_www_form_component(post_text)

puts ""
puts "  ###########################"
puts "  #       %<your_answer>s      #" % {your_answer:decode('44GC44Gq44Gf44Gu5Zue562U')}
puts "  ###########################"
puts ""
puts "  %<shop>s" % {shop:decode('44CQQ1RP44Gu6Kiq5ZWP44GX44Gf44GK5bqX44CR')}
puts "    - #{shop_names.join("\n    - ")}"
puts ""
puts "  %<balance>s #{balance}%<yen>s" % {balance:decode('44CQQ1RP44Gu5Y+j5bqn5q6L6auY44CR'), yen:decode('5YaG')}
puts ""
puts "  ###########################"
puts "  #       %<score>s          #" % {score:decode('5o6h54K557WQ5p6c')}
puts "  ###########################"
puts ""
puts "  %<rank_result>s" % {rank_result:}
puts "  %<cto_comment>s" % {cto_comment:}
puts ""
puts "    %<bonus_result>s" % {bonus_result:} if rank == 'S'
puts "    %<balance_result>s" % {balance_result:}
puts "    %<shop_result>s" % {shop_result:}
puts ""
puts "  %<post_suggestion>s" % {post_suggestion:decode('57WQ5p6c44KSWOOBq+aKleeov+OBl+OBpuOBv+OBvuOBm+OCk+OBi++8nw==')}
puts "  %<finger>s %<post_url>s" % {finger:decode('8J+RiQ=='), post_url:}
puts ""
