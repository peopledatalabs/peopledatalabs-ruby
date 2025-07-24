# frozen_string_literal: true

module Peopledatalabs
  class Bulk < APIResource
    def self.person(params:)
      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
        'SDK-Version' => Peopledatalabs::VERSION,
      }
      post(path: '/v5/person/bulk', headers: headers, body: params)
    end

    def self.company(params:)
      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
        'SDK-Version' => Peopledatalabs::VERSION,
      }
      post(path: '/v5/company/enrich/bulk', headers: headers, body: params)
    end
  end
end
