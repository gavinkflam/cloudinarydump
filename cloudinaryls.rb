# frozen_string_literal: true

require_relative 'lib/ls'
require_relative 'lib/utils'

# Extract params for listing resources from environment variables
params = Cloudinarydump::Utils.compact_params(
  Cloudinarydump::Utils.load_params_from_env(
    :cloud_name, :api_key, :api_secret, :extract
  )
)

results = Cloudinarydump::List.ls(params)
Cloudinarydump::Utils.put_results(results)
