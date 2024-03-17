# frozen_string_literal: true

require 'net/http'
require 'json'
require 'yaml'

class GampClient
  ANALYTICS_PATH = 'https://www.google-analytics.com/mp/collect'
  EVENT_NAME = 'usd_uah_hourly_rate'
  CLIENT_ID = '12345'

  attr_reader :currency, :rate_buy, :rate_sell

  # TODO: use **args
  def self.send_rate_event(currency:, rate_buy:, rate_sell:)
    new(currency: currency, rate_buy: rate_buy, rate_sell: rate_sell)
      .send_rate_event
  end

  def initialize(currency:, rate_buy:, rate_sell:)
    @currency = currency
    @rate_buy = rate_buy
    @rate_sell = rate_sell
  end

  def send_rate_event
    uri = URI(ANALYTICS_PATH)
    uri.query = query

    request = Net::HTTP::Post.new(uri, headers)
    request.body = payload.to_json

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end

  private

  def gamp_credentials
    YAML.load_file('config.yml')
  end

  def query
    URI.encode_www_form(
      api_secret: gamp_credentials['gamp_api_secret'],
      measurement_id: gamp_credentials['gamp_meaasurement_id']
    )
  end

  def headers
    { 'Content-Type' => 'application/json' }
  end

  def payload
    {
      client_id: CLIENT_ID,
      non_personalized_ads: false,
      events: {
        name: EVENT_NAME,
        params: {
          currency: currency,
          rateBuy: rate_buy,
          rateSell: rate_sell
        }
      }
    }
  end
end
