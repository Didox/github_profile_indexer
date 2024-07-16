class UrlShortenerService
  def initialize(url)
    @url = url
    @client = Bitly::API::Client.new(token: ENV['TOKEN_BITLY'])
  end

  def shorten
    response = @client.shorten(long_url: @url)
    response.link
  rescue StandardError => e
    Rails.logger.error "Error shortening URL: #{e.message}"
    nil
  end
end
