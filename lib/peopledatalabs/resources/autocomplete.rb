# frozen_string_literal: true

module Peopledatalabs
  class Autocomplete < APIResource
    def self.retrieve(field:, text: '', size: 10, pretty: false, titlecase: false)

      params = {
        'field' => field,
        'text' => text,
        'size' => size,
        'pretty' => pretty,
        'titlecase' => titlecase,
      };

      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
        'SDK-Version' => Peopledatalabs::VERSION,
      }
      get(path: '/v5/autocomplete', headers: headers, params: params)
    end
  end
end
