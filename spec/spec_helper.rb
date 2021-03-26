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
  c.warnings = true
  c.expose_dsl_globally = true
  c.order = :random

  if c.files_to_run.one?
    c.default_formatter = "doc"
  end

  Kernel.srand c.seed

  c.include TestHelpers
end

RspecApiDocumentation.configure do |c|
  c.app = ResuelveFc.new
  c.format = :json

  # Output folder
  c.docs_dir = File.join(APP_ROOT, "docs")

  # An array of output format(s).
  # Possible values are :json, :html, :combined_text, :combined_json,
  #   :json_iodocs, :textile, :markdown, :append_json, :slate,
  #   :api_blueprint, :open_api
  c.format = [:html]

  # Location of templates
  c.template_path = "inside of the gem"

  # Filter by example document type
  # c.exclusion_filter = nil

  # By default examples and resources are ordered by description. Set to true keep
  # the source order.
  c.keep_source_order = true

  # Change the name of the API on index pages
  c.api_name = "ResuelveFc API Documentation"

  # Redefine what method the DSL thinks is the client
  # This is useful if you need to `let` your own client, most likely a model.
  c.client_method = :client

  # You can define documentation groups as well. A group allows you generate multiple
  # sets of documentation.
  # c.define_group :public do |config|
  # By default the group's doc_dir is a subfolder under the parent group, based
  # on the group's name.
  # **WARNING*** All contents of the configured directory will be cleared, use a dedicated directory.
  # c.docs_dir = Rails.root.join("doc", "api", "public")

  # Change the filter to only include :public examples
  # c.filter = :public
  # end

  # Change how the post body is formatted by default, you can still override by `raw_post`
  # Can be :json, :xml, or a proc that will be passed the params
  c.request_body_formatter = :json

  # Change how the response body is formatted by default
  # Is proc that will be called with the response_content_type & response_body
  # by default, a response body that is likely to be binary is replaced with the string
  # "[binary data]" regardless of the media type.  Otherwise, a response_content_type of `application/json` is pretty formatted.
  c.response_body_formatter = proc { |response_content_type, response_body| response_body }
end
