# spec/services/url_shortener_service_spec.rb
require 'rails_helper'

RSpec.describe UrlShortenerService, type: :service do
  let(:url) { "https://github.com/testuser" }
  let(:shortened_url) { "http://bit.ly/testuser" }
  let(:client) { double(Bitly::API::Client) }
  let(:response) { double('BitlyResponse', link: shortened_url) }

  before do
    allow(Bitly::API::Client).to receive(:new).and_return(client)
  end

  describe '#shorten' do
    context 'when the URL shortening is successful' do
      it 'returns the shortened URL' do
        allow(client).to receive(:shorten).with(long_url: url).and_return(response)

        service = UrlShortenerService.new(url)
        result = service.shorten

        expect(result).to eq(shortened_url)
      end
    end

    context 'when an error occurs during URL shortening' do
      it 'logs the error and returns nil' do
        allow(client).to receive(:shorten).with(long_url: url).and_raise(StandardError.new("Shortening error"))

        service = UrlShortenerService.new(url)
        expect(Rails.logger).to receive(:error).with("Error shortening URL: Shortening error")

        result = service.shorten

        expect(result).to be_nil
      end
    end
  end
end
