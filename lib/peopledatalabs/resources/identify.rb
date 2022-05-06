# frozen_string_literal: true

module Peopledatalabs
  class Identify < APIResource
    def self.person(params:)
      # TODO: possibly add gzip encoding
      # headers = { 'Accept-Encoding' => 'gzip' }
      get(path: '/v5/person/identify', params: params)
    end
  end
end
