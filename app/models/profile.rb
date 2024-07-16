class Profile < ApplicationRecord
	has_one :profile_info, dependent: :destroy
	accepts_nested_attributes_for :profile_info

	after_create :shorten_github_url

  private

  def shorten_github_url
    short_url = UrlShortenerService.new(github_url).shorten
    update(short_github_url: short_url) if short_url.present?
  end
end
