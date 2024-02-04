require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'json'

set :bind, '0.0.0.0'
set :port, 3000

payment = Mutex.new
balance = 0
shop_names = []

# 初期化
post '/init' do
  balance = 100000 # 所持金10万円からスタート！
  shop_names = []  # 訪問した店舗名を記録して思い出にする！
end

post '/payments' do
  body = JSON.parse(request.body.read)

  # NOTE: HTTPヘッダーには `HTTP_` prefixが付くので注意
  # See https://github.com/rack/rack/blob/main/SPEC.rdoc#:~:text=for%20the%20request.-,HTTP_%20Variables,-Variables%20corresponding%20to

  payment.synchronize do
    balance -= Integer(body["amount"])
    shop_names << body["shop_name"]
  end

  status 201
end

get '/summary' do
  status 200
  json balance: balance, shop_names: shop_names.sort
end
