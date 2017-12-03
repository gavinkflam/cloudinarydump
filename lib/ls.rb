# frozen_string_literal: true

require 'cloudinary'
require 'oj'

module Cloudinarydump
  module List
    def self.ls(**params)
      results = list_resources(apply_default_params(params))

      # Extract specific column if required
      if params.key?(:extract)
        results.map { |r| r[params[:extract]] }
      else
        results
      end
    end

    DEFAULT_PARAMS = {
      max_results: 500
    }.freeze

    def self.list_resources(**params)
      results   = Cloudinary::Api.resources(params)
      resources = results['resources']

      # Recursively follow nexe page
      if results.key?('next_cursor')
        resources +
          list_resources(params.merge(next_cursor: results['next_cursor']))
      else
        resources
      end
    end

    private_class_method :list_resources

    def self.apply_default_params(**params)
      DEFAULT_PARAMS.merge(params)
    end

    private_class_method :apply_default_params
  end
end
