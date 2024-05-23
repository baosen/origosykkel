require 'json'
require 'http'

class MapsController < ApplicationController
    # Tell which method to call before the action method.
    before_action :setup, only: [:show, :stands]

    def show
        @stands = all
    end

    # Returns a list of stations.
    def stands
        render json: all
    end

    private
        # Called before the actions to setup the endpoints to retrieve data from oslobysykkel.no.
        def setup
            # Get oslobysykkel.no's endpoints from its auto-discovery endpoint.
            @endpoints = JSON.parse(get('https://gbfs.urbansharing.com/oslobysykkel.no/gbfs.json'))['data']['nb']['feeds']
            @endpoints.each do |endpoint|
                case endpoint['name']
                when "system_information"
                    @system_information_endpoint = endpoint['url'] # not used by this app.
                when "vehicle_types"
                    @vehicle_types_endpoint = endpoint['url'] # not used by this app.
                when "system_pricing_plans"
                    @system_pricing_plans_endpoint = endpoint['url'] # not used by this app.
                when "station_information"
                    @station_information_endpoint = endpoint['url']
                when "station_status"
                    @station_status_endpoint = endpoint['url']
                end
            end
        end

        # Returns a list of Oslo Bysykkel stations from its REST API.
        def get_stations
            JSON.parse(get(@station_information_endpoint))['data']['stations']
        end

        # Returns a list of statuses of stations from its REST API.
        def get_statuses
            JSON.parse(get(@station_status_endpoint))['data']['stations']
        end

        # Return all stands.
        def all
            index = get_stations.group_by { |station| station['station_id'] }
            return get_statuses.flat_map do |status|
                if index[status['station_id']]
                index[status['station_id']].map { |station| status.merge(station) }
                else
                []
                end
            end
        end

        # Do a HTTP Get with a client identifier according to Oslo bysykkel's documentation:
        # https://oslobysykkel.no/apne-data/sanntid
        def get(uri)
            HTTP.headers(
                'Client-Identifier' => 'baosen-origosykkel' # should be in format '<firm/organization>-<application name>', because oslobysykkel.no wants it that way.
            ).get(uri)
        end
end
