module Peopledatalabs
  class APIResource

    protected

    VALID_AUTOCOMPLETE_FIELDS = ['company', 'country', 'industry', 'location', 'major', 'region', 'role', 'school', 'sub_role', 'skill', 'title'].freeze

    def self.get(path:, headers: {}, params: {})
      request = check(params: params, path: path)
      return request unless request['status'] == 200

      response = HTTP
                   .use(:auto_inflate)
                   .timeout(Peopledatalabs.read_timeout)
                   .headers(headers)
                   .get(url(path), params: query_authentication(params))
      handle_response(response)
    end

    def self.post(path:, headers: {}, body: {})
      request = check(params: body, path: path)
      return request unless request['status'] == 200

      response = HTTP
                   .use(:auto_inflate)
                   .timeout(Peopledatalabs.read_timeout)
                   .headers(header_authentication(headers))
                   .post(url(path), json: body)
      handle_response(response)
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

    def self.check(params:, path:)
      result = { 'status' => 200 }

      if !Peopledatalabs.api_key
        result = {
          'status' => 401,
          'message' => 'Invalid API Key'
        }
      elsif !Peopledatalabs.api_base
        result = {
          'status' => 400,
          'message' => 'Missing API Base Path'
        }
      elsif params.empty?
        result = {
          'status' => 400,
          'message' => "Missing Params"
        }
      elsif path.include? '/search'
        query = params['sql'] || params['query']
        result = { 'status' => 400, 'message' => 'Missing searchQuery' } unless query
      elsif path.include?'/retrieve'
        result = { 'status' => 400, 'message' => 'Missing id' } unless path.match(/\/retrieve\/.+$/)
      elsif path.include? '/autocomplete'
        field = params['field']
        if (!field)
          result = { 'status' => 400, 'message' => 'Missing field' }
        elsif (!VALID_AUTOCOMPLETE_FIELDS.include?(field))
          result = { 'status' => 400, 'message' => "Field should be one of: #{VALID_AUTOCOMPLETE_FIELDS.join(', ')}" }
        end
      elsif path.include? '/job_title'
        field = params['job_title']
        if (!field)
          result = { 'status' => 400, 'message' => 'Missing job_title' }
        end
      elsif path.include? '/skill'
        field = params['skill']
        if (!field)
          result = { 'status' => 400, 'message' => 'Missing skill' }
        end
      end
      result
    end

    def self.handle_response(response)
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

      rate_limit_remaining = response.headers['X-RateLimit-Remaining'] ? JSON.parse(response.headers['X-RateLimit-Remaining'].gsub("'",'"')) : {}
      rate_limit_limit = response.headers['X-RateLimit-Limit'] ? JSON.parse(response.headers['X-RateLimit-Limit'].gsub("'",'"')) : {}

      rate_limit = {
        'call_credits_spent' => to_number(response.headers['X-Call-Credits-Spent']),
        'call_credits_type' => response.headers['X-Call-Credits-Type'],
        'rate_limit_reset' => response.headers['X-RateLimit-Reset'],
        'rate_limit_remaining' => {
          'minute' => to_number(rate_limit_remaining['minute']),
          'day' => to_number(rate_limit_remaining['day']),
          'month' => to_number(rate_limit_remaining['month'])
        },
        'rate_limit_limit' => {
          'minute' => to_number(rate_limit_limit['minute']),
          'day' => to_number(rate_limit_limit['day']),
          'month' => to_number(rate_limit_limit['month'])
        },
        'lifetime_used' => to_number(response.headers['X-Lifetime-Used']),
        'total_limit_remaining' => to_number(response.headers['X-TotalLimit-Remaining']),
        'total_limit_purchased_remaining' => to_number(response.headers['X-TotalLimit-Purchased-Remaining']),
        'total_limit_overages_remaining' => to_number(response.headers['X-TotalLimit-Overages-Remaining'])
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
