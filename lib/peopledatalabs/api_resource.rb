module Peopledatalabs
  class APIResource

    protected

    def self.get(path:, headers: {}, params: {})
      response = HTTP
        .timeout(Peopledatalabs.read_timeout)
        .headers(headers)
        .get(url(path), params: query_authentication(params))
      rate_limits(response)
    end

    def self.post(path:, headers: {}, body: {})
      response = HTTP
        .timeout(Peopledatalabs.read_timeout)
        .headers(header_authentication(headers))
        .post(url(path), json: body)
      rate_limits(response)
    end

    def self.url(path)
      "#{Peopledatalabs.api_base}#{path}"
    end

    def self.query_authentication(params)
      params.merge({ :api_key => Peopledatalabs.api_key })
    end

    def self.header_authentication(headers)
      headers.merge({ 'X-Api-Key' => Peopledatalabs.api_key })
    end

    def self.to_number(number)
      return number if number.nil?

      Float(number)
      i, f = number.to_i, number.to_f
      i == f ? i : f
    rescue ArgumentError
      nil
    end

    def self.rate_limits(response)
      # Would prefer to keep consistent and always put it in data but right now matching the js lib response
      # {
      #   'retry_after' => to_number(response.headers['Retry-After']),
      #   'rate_limit' => to_number(response.headers['X-RateLimit-Limit']),
      #   'rateLimit_reset' => to_number(response.headers['X-RateLimit-Reset']),
      #   'total_limit' => to_number(response.headers['X-TotalLimit-Limit']),
      #   'total_limit_remaining' => to_number(response.headers['X-RateLimit-Remaining']),
      #   'search_limit_remaining' => to_number(response.headers['X-SearchLimit-Remaining']),
      #   'enrich_company_limit_remaining' => to_number(response.headers['X-EnrichCompanyLimit-Remaining']),
      #   'person_identify_limit_remaining' => to_number(response.headers['X-PersonIdentifyLimit-Remaining'])
      #   'data' => response.parse
      # }

      rate_limit = {
        'retry_after' => to_number(response.headers['Retry-After']),
        'rate_limit' => to_number(response.headers['X-RateLimit-Limit']),
        'rateLimit_reset' => to_number(response.headers['X-RateLimit-Reset']),
        'total_limit' => to_number(response.headers['X-TotalLimit-Limit']),
        'total_limit_remaining' => to_number(response.headers['X-RateLimit-Remaining']),
        'search_limit_remaining' => to_number(response.headers['X-SearchLimit-Remaining']),
        'enrich_company_limit_remaining' => to_number(response.headers['X-EnrichCompanyLimit-Remaining']),
        'person_identify_limit_remaining' => to_number(response.headers['X-PersonIdentifyLimit-Remaining'])
      }

      parsed_response = response.parse
      if response.parse.is_a? Array
        rate_limit.merge('items' => parsed_response)
      else
        rate_limit.merge(parsed_response)
      end
    end
  end
end
