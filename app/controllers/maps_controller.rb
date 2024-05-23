class MapsController < ApplicationController
    # Tell which method to call before the action method.
    before_action :setup, only: [:show, :stations, :status]

    def show
        require 'json'

        @endpoints = JSON.parse(get('https://gbfs.urbansharing.com/oslobysykkel.no/gbfs.json'))['data']['nb']['feeds']
        @endpoints.each do |endpoint|
            case endpoint['name']
            when "system_information"
                @system_information_endpoinbt = endpoint['url']
            when "vehicle_types"
                @vehicle_types_endpoint = endpoint['url']
            when "system_pricing_plans"
                @system_pricing_plans_endpoint = endpoint['url']
            when "station_information"
                @station_information_endpoint = endpoint['url']
            when "station_status"
                @station_status_endpoint = endpoint['url']
            end
        end

        @stations = JSON.parse(get(@station_information_endpoint))['data']['stations']
        @station_status = JSON.parse(HTTP.get(@station_status_endpoint))['data']['stations']
    end

    # Returns a list of stations.
    def stations
        render json: JSON.parse(get(@station_information_endpoint))['data']['stations']
    end

    # Returns a list of station status.
    def status
        render json: JSON.parse(get(@station_status_endpoint))['data']['stations']
    end

    private
        # Called before the actions to setup the endpoints to retrieve data from oslobysykkel.no.
        def setup
            require 'http'

            @endpoints = JSON.parse(get('https://gbfs.urbansharing.com/oslobysykkel.no/gbfs.json'))['data']['nb']['feeds']
            @endpoints.each do |endpoint|
                case endpoint['name']
                when "system_information"
                    @system_information_endpoinbt = endpoint['url']
                when "vehicle_types"
                    @vehicle_types_endpoint = endpoint['url']
                when "system_pricing_plans"
                    @system_pricing_plans_endpoint = endpoint['url']
                when "station_information"
                    @station_information_endpoint = endpoint['url']
                when "station_status"
                    @station_status_endpoint = endpoint['url']
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
