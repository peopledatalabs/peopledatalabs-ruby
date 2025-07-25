# frozen_string_literal: true

module Peopledatalabs
  class Cleaner < APIResource
    def self.company(kind:, value:)
      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
        'SDK-Version' => Peopledatalabs::VERSION,
      }
      get(path: '/v5/company/clean', headers: headers, params: { kind => value })
    end

    def self.school(kind:, value:)
      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
        'SDK-Version' => Peopledatalabs::VERSION,
      }
      get(path: '/v5/school/clean', headers: headers, params: { kind => value })
    end

    def self.location(value:)
      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
        'SDK-Version' => Peopledatalabs::VERSION,
      }
      get(path: '/v5/location/clean', headers: headers, params: { 'location' => value })
    end


  end
end
