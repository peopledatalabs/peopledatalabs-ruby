# frozen_string_literal: true

module Peopledatalabs
    class JobTitle < APIResource
      def self.retrieve(job_title:, pretty: false, titlecase: false)
  
        params = {
          'job_title' => job_title,
          'pretty' => pretty,
          'titlecase' => titlecase,
        };
  
        headers = {
          'Accept-Encoding' => 'gzip',
          'User-Agent' => 'PDL-RUBY-SDK',
          'SDK-Version' => Peopledatalabs::VERSION,
        }
        get(path: '/v5/job_title/enrich', headers: headers, params: params)
      end
    end
  end
  