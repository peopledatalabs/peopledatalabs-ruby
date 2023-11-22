# frozen_string_literal: true

module Peopledatalabs
    class Skill < APIResource
      def self.retrieve(skill:, pretty: false, titlecase: false)
  
        params = {
          'skill' => skill,
          'pretty' => pretty,
          'titlecase' => titlecase,
        };
  
        headers = {
          'Accept-Encoding' => 'gzip',
          'User-Agent' => 'PDL-RUBY-SDK',
        }
        get(path: '/v5/skill/enrich', headers: headers, params: params)
      end
    end
  end
  