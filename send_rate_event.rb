# frozen_string_literal: true

require_relative './mono_client.rb'
require_relative './gamp_client.rb'
require 'logger'

logger = Logger.new(STDOUT)

logger.info('[MONO] Fetching USD rate.')
mono_response = MonoClient.fetch_rate(currency: 'USD')
logger.info("[MONO] USD rates: rateBuy: #{mono_response['rateBuy']}, rateSell: #{mono_response['rateSell']}")
logger.info('[MONO] USD rate fetched successfully!')

logger.info('[GAMP] Sending USD rate to GAMP.')
response = GampClient.send_rate_event(
             currency: 'USD',
             rate_buy: mono_response['rateBuy'],
             rate_sell: mono_response['rateSell']
           )
logger.info("[GAMP] Response status: #{response.code}")
logger.info('[GAMP] USD rate was successfully sent to GAMP!')
