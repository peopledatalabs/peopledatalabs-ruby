# frozen_string_literal: true

module Peopledatalabs
  class Configuration
    attr_accessor :api_key
    attr_accessor :api_base
    attr_accessor :read_timeout

    def self.setup
      new.tap do |instance|
        yield(instance) if block_given?
      end
    end

    def initialize
      @api_base = "https://api.peopledatalabs.com"
      @read_timeout = 10
    end

  end
end
