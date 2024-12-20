# frozen_string_literal: true

module Peopledatalabs
  class Search < APIResource
    def self.person(searchType:, query: , titlecase: false, dataset: 'all', size: 10, pretty: false, scroll_token: nil, updated_title_roles: false)
      search(searchType: searchType,
             query: query,
             titlecase: titlecase,
             dataset: dataset, size: size,
             pretty: pretty,
             scroll_token: scroll_token,
             kind: 'person')
    end

    def self.company(searchType:, query: , titlecase: false, dataset: 'all', size: 10, pretty: false, scroll_token: nil)
      search(searchType: searchType,
             query: query,
             titlecase: titlecase,
             dataset: dataset, size: size,
             pretty: pretty,
             scroll_token: scroll_token,
             kind: 'company')
    end

    def self.search(searchType:, query:, kind:, titlecase: false, dataset: 'all', size: 10, pretty: false, scroll_token: nil)

      body = {
        searchType === 'sql' ? 'sql' : 'query' => query,
        'dataset' => dataset,
        'size' => size,
        'pretty' => pretty,
        'titlecase' => titlecase,
        'scroll_token' => scroll_token,
      }

      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
      }
      post(path: "/v5/#{kind}/search", headers: headers, body: body)
    end
  end
end
