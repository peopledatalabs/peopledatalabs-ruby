# frozen_string_literal: true

module Peopledatalabs
  class Identify < APIResource
    def self.person(params:)
      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
        'SDK-Version' => Peopledatalabs::VERSION,
      }
      get(path: '/v5/person/identify', headers: headers, params: params)
    end
  end
end
