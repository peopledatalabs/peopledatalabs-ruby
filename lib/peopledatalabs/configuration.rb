# frozen_string_literal: true

module Peopledatalabs
  class Configuration
    attr_accessor :api_key
    attr_accessor :sandbox
    attr_accessor :read_timeout

    def self.setup
      new.tap do |instance|
        yield(instance) if block_given?
      end
    end

    def initialize
      @read_timeout = 10
      @api_key ||= ENV['PDL_API_KEY']
      @sanbox = false
    end

    def api_base
      sandbox ? 'https://sandbox.api.peopledatalabs.com' : 'https://api.peopledatalabs.com'
    end
  end
end
