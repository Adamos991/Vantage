require "tweepy"

client =
  Tweepy::Client.new do |config|
    config.consumer_key = "hat0ycHVaaTZ01q1gBojO32hj"
    config.consumer_secret =
      "ZOuViiSkqm290PXyeUeJbg6dBFMfpHY58IsVm2m38METl0PhxY"
    config.access_token = "2987702841-dvC5iFh3DaMv2CYV3ML8lDvBPKsMKJny31EuN4j"
    config.access_token_secret = "wN1QoBY4kYFRDVhH9rx5u8i2Pr8tCmgeDmbp2WQrKuMaN"
  end

trends = client.trends(id = 1).take(50)

trends.each { |trend| Trend.create!(name: trend.name, url: trend.url) }
