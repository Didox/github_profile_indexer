class GithubScraper
  def initialize(url)
    @url = url
    @username = url.split('/').last
    response = HTTParty.get(url)

    raise "Empty response body for URL: #{url}" if response && (response.body.nil? || response.body.empty?)

    @parsed_page = Nokogiri::HTML(response.body)
  end

  def scrape
    contributions = fetch_contributions
    {
      username: @parsed_page.css('.p-nickname.vcard-username.d-block').text.strip,
      followers: @parsed_page.css('a[href$="tab=followers"] .text-bold').text.strip,
      following: @parsed_page.css('a[href$="tab=following"] .text-bold').text.strip,
      stars: @parsed_page.css('a[data-tab-item="stars"] .Counter').first&.text&.strip,
      contributions: contributions,
      profile_image_url: @parsed_page.css('.avatar-user').first['src'],
      organization: @parsed_page.css('.p-org').text.strip.presence,
      location: @parsed_page.css('.p-label').text.strip.presence
    }
  end

  private

  def fetch_contributions
    contributions_url = "https://github.com/users/#{@username}/contributions"
    response = HTTParty.get(contributions_url)

    return "0" if response.body.nil? || response.body.empty?

    contributions_page = Nokogiri::HTML(response.body)
    contributions_text = contributions_page.css('.js-yearly-contributions h2.text-normal').text.strip
    contributions_text.split.first
  end
end
