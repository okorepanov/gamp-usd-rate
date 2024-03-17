# README

## Description
Repository with Mono API integration to fetch USD-UAH currency rate and send it to Google Analytics4 via Measurement Protocol

## Setup
This code is then set up via `crontab` - `0 * * * * cd path/to/repository && ruby send_event_rate.rb`

## Configuration
Pass your own GAMP credentials to corresponding keys in `config.yml` file