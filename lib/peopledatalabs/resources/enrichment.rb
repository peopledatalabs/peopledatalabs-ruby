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

    def self.ip(ip:, return_ip_location: false, return_ip_metadata: false, return_person: false)
      params = {
        'ip' => ip,
        'return_ip_location' => return_ip_location,
        'return_ip_metadata' => return_ip_metadata,
        'return_person' => return_person,
        'return_if_unmatched' => return_if_unmatched,
      }
      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
      }
      get(path: '/v5/ip/enrich', headers: headers, params: params)
    end

  end
end
