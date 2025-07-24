# frozen_string_literal: true

module Peopledatalabs
  class Changelog < APIResource
    def self.person(params:)
      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
        'SDK-Version' => Peopledatalabs::VERSION,
      }

      stringified_params = params.transform_keys(&:to_s)

      post(path: '/v5/person/changelog', headers: headers, body: stringified_params)
    end
  end
end
