class GithubScraper
    def initialize(url)
      @url = url
      @parsed_page = Nokogiri::HTML(HTTParty.get(url))
    end
  
    def scrape
      {
        username: @parsed_page.css('.p-nickname.vcard-username.d-block').text.strip,
        followers: @parsed_page.css('a[href$="tab=followers"] .text-bold').text.strip,
        following: @parsed_page.css('a[href$="tab=following"] .text-bold').text.strip,
        stars: @parsed_page.css('a[href$="tab=stars"] .text-bold').text.strip,
        contributions: @parsed_page.css('.js-yearly-contributions h2').text.strip.split.first,
        profile_image_url: @parsed_page.css('.avatar-user').first['src'],
        organization: @parsed_page.css('.p-org').text.strip.presence,
        location: @parsed_page.css('.p-label').text.strip.presence
      }
    end
end
  
