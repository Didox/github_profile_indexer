require 'rails_helper'

RSpec.describe GithubScraper, type: :service do
  let(:github_url) { 'https://github.com/testuser' }
  let(:contributions_url) { 'https://github.com/users/testuser/contributions' }
  let(:html_body) do
    <<-HTML
      <div class="p-nickname vcard-username d-block">testuser</div>
      <a href="/testuser?tab=followers"><span class="text-bold">10</span></a>
      <a href="/testuser?tab=following"><span class="text-bold">5</span></a>
      <a data-tab-item="stars"><span class="Counter">15</span></a>
      <div class="js-yearly-contributions"><h2 class="text-normal">20 contributions in the last year</h2></div>
      <img class="avatar-user" src="https://github.com/images/error/testuser_happy.gif" />
      <div class="p-org">Test Org</div>
      <div class="p-label">Test Location</div>
    HTML
  end
  let(:contributions_body) do
    <<-HTML
      <div class="js-yearly-contributions">
        <h2 class="text-normal">20 contributions in the last year</h2>
      </div>
    HTML
  end

  before do
    stub_request(:get, github_url).to_return(status: 200, body: html_body)
    stub_request(:get, contributions_url).to_return(status: 200, body: contributions_body)
  end

  describe '#scrape' do
    it 'returns the correct profile data' do
      scraper = GithubScraper.new(github_url)
      result = scraper.scrape

      expect(result[:username]).to eq('testuser')
      expect(result[:followers]).to eq('10')
      expect(result[:following]).to eq('5')
      expect(result[:stars]).to eq('15')
      expect(result[:contributions]).to eq('20')
      expect(result[:profile_image_url]).to eq('https://github.com/images/error/testuser_happy.gif')
      expect(result[:organization]).to eq('Test Org')
      expect(result[:location]).to eq('Test Location')
    end
  end

  describe '#initialize' do
    context 'when the response body is empty' do
      before do
        stub_request(:get, github_url).to_return(status: 200, body: '')
      end

      it 'raises an error' do
        expect { GithubScraper.new(github_url) }.to raise_error(RuntimeError, "Empty response body for URL: #{github_url}")
      end
    end
  end

  describe '#fetch_contributions' do
    it 'returns the correct number of contributions' do
      scraper = GithubScraper.new(github_url)
      expect(scraper.send(:fetch_contributions)).to eq('20')
    end

    context 'when the contributions response body is empty' do
      before do
        stub_request(:get, contributions_url).to_return(status: 200, body: '')
      end

      it 'returns 0 contributions' do
        scraper = GithubScraper.new(github_url)
        expect(scraper.send(:fetch_contributions)).to eq('0')
      end
    end
  end
end
