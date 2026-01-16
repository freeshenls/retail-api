ENV["RAILS_MASTER_KEY"] = "a77c752e1b1ffd57e4e1baf4b110bbd1"
ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
