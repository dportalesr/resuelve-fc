ENV["RACK_ENV"] = "test"

require_relative "../app"

RSpec.configure do |c|
  c.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  c.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  c.shared_context_metadata_behavior = :apply_to_host_groups
  c.filter_run_when_matching :focus
  c.example_status_persistence_file_path = "spec/examples.txt"
  c.disable_monkey_patching!
  c.warnings = true
  c.expose_dsl_globally = true
  c.order = :random

  if c.files_to_run.one?
    c.default_formatter = "doc"
  end

  Kernel.srand c.seed
end
