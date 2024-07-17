class ProfileService
  def initialize(profile)
    @profile = profile
  end

  def self.save(profile_params)
    profile = Profile.new(profile_params)
    ActiveRecord::Base.transaction do
      ProfileService.new(profile).scraper_and_shorten_github_url! if profile.save
    end
    profile
  rescue StandardError => e
    ProfileService.error_profile(profile, e)
  end

  def self.update(profile, profile_params)
    return profile if profile.blank?

    ActiveRecord::Base.transaction do
      ProfileService.new(profile).scraper_and_shorten_github_url! if profile.update(profile_params)
    end
    profile
  rescue StandardError => e
    ProfileService.error_profile(profile, e)
  end

  def scraper_and_shorten_github_url!
    scraper!
    shorten_github_url!
  end

  def scraper!
    return if @profile.blank?

    scraper = GithubScraper.new(@profile.github_url)
    scraped_data = scraper.scrape
    if @profile.profile_info.present?
      @profile.profile_info.update!(scraped_data)
    else
      @profile.create_profile_info!(scraped_data)
    end
  end

  def shorten_github_url!
    return if @profile.blank?

    short_url = UrlShortenerService.new(@profile.github_url).shorten
    @profile.update!(short_github_url: short_url) if short_url.present?
  end

  def self.error_profile(profile, error)
    profile.errors.add(:base, "Informações do perfil do Github: #{error.message}")
    profile
  end
end
