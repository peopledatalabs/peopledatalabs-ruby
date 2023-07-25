# frozen_string_literal: true

module Peopledatalabs
  class Enrichment < APIResource
    def self.person(params:)
      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
      }
      get(path: '/v5/person/enrich', headers: headers, params: params)
    end

    def self.company(params:)
      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
      }
      get(path: '/v5/company/enrich', headers: headers, params: params)
    end

    def self.ip(params:)
      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
      }
      get(path: '/v5/ip/enrich', headers: headers, params: params)
    end

  end
end
