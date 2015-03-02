require 'faraday'
require 'json'

MODEL_API_URL = Edmunds::Vehicle::API_URL_V2

module Edmunds
  module Vehicle
    module Specification
      module Model

        class Model
          attr_reader :id, :name, :years

          def initialize(attributes)
            @id = attributes["id"]
            @name = attributes["name"]
            @years = attributes["years"].map {|json| Edmunds::Vehicle::Specification::ModelYear::ModelYear.new(json)} if attributes.key?("years")
          end

          def self.find(make_name, model_name, api_params = {})
            response = Edmunds::Api.get("#{MODEL_API_URL}/#{make_name}/#{model_name}", api_params)
            attributes = JSON.parse(response.body)
            new(attributes)
          end
        end
      end
    end
  end
end