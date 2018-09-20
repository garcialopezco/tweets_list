class TweetsQuery
  MY_TWITTER_FEED_ENDPOINT = ENV['TWITTER_FEED_URL']
  LIMIT = 10

  def self.search(topic)
    url = "#{MY_TWITTER_FEED_ENDPOINT}/tweets?category=#{topic}"
    response = RestClient.get(url)
    JSON.parse(response, object_class: OpenStruct).first(LIMIT)
  end
end
