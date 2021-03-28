ENV["RACK_ENV"] = "test"

require_relative "../app"
require "rspec_api_documentation/dsl"
require "test_helpers"

RSpec.configure do |c|
  c.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  c.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  c.shared_context_metadata_behavior = :apply_to_host_groups
  c.filter_run_when_matching :focus
  c.run_all_when_everything_filtered = true
  c.example_status_persistence_file_path = "spec/examples.txt"
  c.disable_monkey_patching!
  c.warnings = false
  c.expose_dsl_globally = true

  if c.files_to_run.one?
    c.default_formatter = "doc"
  end

  c.include TestHelpers
end

RspecApiDocumentation.configure do |c|
  c.app = ResuelveFc.new
  c.configurations_dir = Pathname.new File.join(APP_ROOT, "docs", "config")
  c.docs_dir = Pathname.new File.join(APP_ROOT, "docs")

  # An array of output format(s).
  # Possible values are :json, :html, :combined_text, :combined_json,
  #   :json_iodocs, :textile, :markdown, :append_json, :slate,
  #   :api_blueprint, :open_api
  c.format = :json
  c.keep_source_order = false
  c.api_name = "ResuelveFc API Documentation"
  c.client_method = :client
  c.request_body_formatter = :json
  c.response_body_formatter = proc { |response_content_type, response_body| response_body }
end

Rack::Attack.enabled = false
