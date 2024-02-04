require 'csv'
require 'securerandom'

answer_shop_names = [
  "旬と肴と炙り「月あかり」",
  "焼肉・すき焼き とみや別館",
  "キッチネッテ",
  "ビストロ巴里食堂 大手町店",
  "汁なし担担麺 キング軒 大手町本店",
  "リストランテマリオ",
  "お好み焼き みっちゃん 横川店分家",
]
dummy_shop_names = [
  "寿司屋 すし善",
  "パラダイスロスト",
  "そば処 ふる里",
  "うどんや ととや",
  "和食料理 さくらんぼ",
  "刺身の「うまいもん」 うおや 大手町店",
  "おでんや おでん家",
  "とんかつ かつや 大手町店",
  "天ぷら てんや",
  "おんふぇ",
  "しゃぶしゃぶ シャビィ家",
  "焼き鳥 やきとりや",
  "広島やぷし軒",
  "和食 ふぐ家",
  "お茶漬け おちゃづけや",
  "そばや そば屋",
  "旬の和食 こうじや",
  "いちにち",
  "おばんざい 坂本",
  "和食うずら",
  "松屋",
]

amount_range = 800..10000
shop_names = answer_shop_names + dummy_shop_names

shops = {}
answer_shop_names.each do |name|
  shops[name] = (1..5).to_a.sample.times.map do |i|
    { idempotency_key: SecureRandom.uuid, amount: rand(amount_range) }
  end
end
dummy_shop_names.each do |name|
  shops[name] = (1..5).to_a.sample.times.map do |i|
    { idempotency_key: nil, amount: rand(amount_range) }
  end
end

CSV.open(File.expand_path('../../client/requests.csv', __FILE__), "wb", force_quotes: true) do |csv|
  csv << ["amount", "shop_name", "idempotency_key"]

  1000.times do
    shop_name = shop_names.sample
    payment = shops[shop_name].sample

    csv << [payment[:amount], shop_name, payment[:idempotency_key]]
  end
end
