# frozen_string_literal: true

module Peopledatalabs
  class Bulk < APIResource
    def self.people(params:)
      # TODO: possibly add gzip encoding
      # headers = { 'Accept-Encoding' => 'gzip' }
      post(path: '/v5/person/bulk', body: params)
    end
  end
end
