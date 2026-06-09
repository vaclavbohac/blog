ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...

    # Build a Post with valid defaults; override any attribute via keyword args.
    def build_post(**attrs)
      Post.new({ title: "A title", perex: "A perex", body: "A body" }.merge(attrs))
    end

    # Build and persist a Post with valid defaults.
    def create_post(**attrs)
      build_post(**attrs).tap(&:save!)
    end
  end
end
