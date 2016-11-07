# 注：本当に動かす場合はtwitter gemが必要です
#require 'twitter'

class WeatherBot
  def tweet_forecast
    twitter_client.update '今日は晴れです'
  end

  def twitter_client
    Twitter::REST::Client.new
  end

  def notify(error)
    # （エラーの通知を行う。実装は省略）
    pp 'test notify method!!!'
  end
end
