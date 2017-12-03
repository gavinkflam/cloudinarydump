# frozen_string_literal: true

require 'oj'

module Cloudinarydump
  module Utils
    def self.load_params_from_env(*keys)
      keys.each_with_object({}) do |k, o|
        o[k.to_sym] = ENV[k.to_s.upcase]
      end
    end

    def self.compact_params(**params)
      params.delete_if { |_k, v| v.nil? || v == '' }
    end

    def self.put_results(results)
      if results.is_a?(Hash)
        puts Oj.dump(results)
      else
        puts results
      end
    end
  end
end
