# frozen_string_literal: true

module Peopledatalabs
  class JobPosting < APIResource
    # Searches PDL's job_posting dataset.
    #
    # Pass an Elasticsearch-style body via :query, or any of the field-based
    # filters (e.g. :title_role, :company_industry, :remote_work_policy) as
    # keyword arguments. :is_active is opt-in — only sent when the caller
    # supplies it. :scroll_token is the opaque base64 cursor returned by the
    # previous page; pass it back unchanged.
    def self.search(**kwargs)
      return { 'status' => 400, 'message' => 'Missing Params' } if kwargs.empty?

      query = kwargs.delete(:query)
      scroll_token = kwargs.delete(:scroll_token)
      size = kwargs.key?(:size) ? kwargs.delete(:size) : 10
      pretty = kwargs.key?(:pretty) ? kwargs.delete(:pretty) : false

      if size && (size < 1 || size > 100)
        return { 'status' => 400, 'message' => 'size must be between 1 and 100' }
      end

      body = {
        'pretty' => pretty,
        'size' => size,
      }
      body['query'] = query unless query.nil?
      body['scroll_token'] = scroll_token unless scroll_token.nil?
      kwargs.each do |key, value|
        body[key.to_s] = value unless value.nil?
      end

      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
        'SDK-Version' => Peopledatalabs::VERSION,
      }
      post(path: '/v5/job_posting/search', headers: headers, body: body)
    end
  end
end
