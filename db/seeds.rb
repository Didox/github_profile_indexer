profile = Profile.create(name: "Danilo", github_url: "https://github.com/didox")
ProfileService.new(profile).scraper_and_shorten_github_url! if profile.errors.blank?
