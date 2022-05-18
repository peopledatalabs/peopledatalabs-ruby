# frozen_string_literal: true

module Peopledatalabs
  class Autocomplete < APIResource
    def self.retrieve(field:, text: '', size: 10, pretty: false)

      params = {
        'field' => field,
        'text' => text,
        'size' => size,
        'pretty' => pretty,
      };

      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
      }
      get(path: '/v5/autocomplete', headers: headers, params: params)
    end
  end
end
