# frozen_string_literal: true

module Peopledatalabs
    class IP < APIResource
      def self.retrieve(ip:, pretty: false)
  
        params = {
          'ip' => ip,
          'return_ip_location' => return_ip_location,
          'return_ip_metadata' => return_ip_metadata,
          'return_person' => return_person,
          'pretty' => pretty,
        };
  
        headers = {
          'Accept-Encoding' => 'gzip',
          'User-Agent' => 'PDL-RUBY-SDK',
        }
        get(path: '/v5/ip/enrich', headers: headers, params: params)
      end
    end
  end
  