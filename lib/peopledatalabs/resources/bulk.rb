# frozen_string_literal: true

module Peopledatalabs
  class Bulk < APIResource
    def self.people(params:)
      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
      }
      post(path: '/v5/person/bulk', headers: headers, body: params)
    end
  end
end
