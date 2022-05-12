# frozen_string_literal: true

module Peopledatalabs
  class Cleaner < APIResource
    def self.company(kind:, value:)
      # TODO: possibly add gzip encoding
      # headers = { 'Accept-Encoding' => 'gzip' }
      get(path: '/v5/company/clean', params: { kind => value })
    end

    def self.school(kind:, value:)
      # TODO: possibly add gzip encoding
      # headers = { 'Accept-Encoding' => 'gzip' }
      get(path: '/v5/school/clean', params: { kind => value })
    end

    def self.location(value:)
      # TODO: possibly add gzip encoding
      # headers = { 'Accept-Encoding' => 'gzip' }
      get(path: '/v5/location/clean', params: { 'location' => value })
    end


  end
end
