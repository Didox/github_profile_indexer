require 'rails_helper'

RSpec.describe ProfileService, type: :service do
  let(:profile_params) { { name: "Test User", github_url: "https://github.com/testuser" } }
  let(:profile) { create(:profile, profile_params) }
  let(:scraped_data) do
    {
      username: "testuser",
      followers: "10",
      following: "5",
      stars: "15",
      contributions: "20",
      profile_image_url: "https://github.com/images/error/testuser_happy.gif",
      organization: "Test Org",
      location: "Test Location"
    }
  end
  let(:short_url) { "http://short.url/testuser" }

  before do
    allow(GithubScraper).to receive(:new).and_return(double(scrape: scraped_data))
    allow(UrlShortenerService).to receive(:new).and_return(double(shorten: short_url))
  end

  describe '.save' do
    context 'when valid params' do
      it 'saves the profile and scrapes and shortens the GitHub URL' do
        profile = ProfileService.save(profile_params)
        expect(profile).to be_persisted
        expect(profile.profile_info.username).to eq(scraped_data[:username])
        expect(profile.short_github_url).to eq(short_url)
      end
    end

    context 'when invalid params' do
      it 'returns a profile with errors' do
        invalid_params = profile_params.merge(github_url: nil)
        profile = ProfileService.save(invalid_params)
        expect(profile).not_to be_persisted
        expect(profile.errors[:github_url]).to include("can't be blank")
      end
    end
  end

  describe '.update' do
    context 'when valid params' do
      it 'updates the profile and scrapes and shortens the GitHub URL' do
        updated_params = { name: "Updated User", github_url: "https://github.com/updateduser" }
        updated_profile = ProfileService.update(profile, updated_params)
        expect(updated_profile.name).to eq("Updated User")
        expect(updated_profile.profile_info.username).to eq(scraped_data[:username])
        expect(updated_profile.short_github_url).to eq(short_url)
      end
    end

    context 'when invalid params' do
      it 'returns a profile with errors' do
        invalid_params = { github_url: nil }
        updated_profile = ProfileService.update(profile, invalid_params)
        expect(updated_profile.errors[:github_url]).to include("can't be blank")
      end
    end
  end

  describe '#scraper_and_shorten_github_url!' do
    it 'calls scraper! and shorten_github_url!' do
      service = ProfileService.new(profile)
      expect(service).to receive(:scraper!).and_call_original
      expect(service).to receive(:shorten_github_url!).and_call_original
      service.scraper_and_shorten_github_url!
    end
  end

  describe '#scraper!' do
    it 'scrapes GitHub data and updates the profile info' do
      service = ProfileService.new(profile)
      service.scraper!
      expect(profile.profile_info.username).to eq(scraped_data[:username])
      expect(profile.profile_info.followers).to eq(scraped_data[:followers])
    end
  end

  describe '#shorten_github_url!' do
    it 'shortens the GitHub URL and updates the profile' do
      service = ProfileService.new(profile)
      service.shorten_github_url!
      expect(profile.short_github_url).to eq(short_url)
    end
  end

  describe '.error_profile' do
    it 'adds an error message to the profile' do
      error = StandardError.new("Test error")
      ProfileService.error_profile(profile, error)
      expect(profile.errors[:base]).to include("Informações do perfil do Github: Test error")
    end
  end
end
