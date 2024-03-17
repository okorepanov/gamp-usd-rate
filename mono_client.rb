# frozen_string_literal: true

require 'net/http'
require 'json'

class MonoClient
  CURRENCY_CODES = { 'USD' => 840 }.freeze
  CURRENCY_URI = URI('https://api.monobank.ua/bank/currency')

  class << self
    def fetch_rate(currency:)
      JSON.parse(fetch_all_rates)
          .find { |currencies| currencies['currencyCodeA'] == CURRENCY_CODES[currency] }
    end

    private

    def fetch_all_rates
      Net::HTTP.get(CURRENCY_URI)
    end
  end
end
