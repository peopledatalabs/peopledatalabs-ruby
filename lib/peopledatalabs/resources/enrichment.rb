# frozen_string_literal: true

module Peopledatalabs
  class Enrichment < APIResource
    def self.person(params:)
      # TODO: possibly add gzip encoding
      # headers = { 'Accept-Encoding' => 'gzip' }
      get(path: '/v5/person/enrich', params: params)
    end

    def self.company(params:)
      # TODO: possibly add gzip encoding
      # headers = { 'Accept-Encoding' => 'gzip' }
      get(path: '/v5/company/enrich', params: params)
    end

  end
end
