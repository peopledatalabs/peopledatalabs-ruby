# frozen_string_literal: true

module Peopledatalabs
  class Search < APIResource
    def self.people(searchType:, query: , titlecase: false, dataset: 'all', size: 10, pretty: false, scroll_token: nil)

      body = {
        searchType === 'sql' ? 'sql' : 'query' => query,
        dataset => dataset,
        size => size,
        pretty => pretty,
        titlecase => titlecase,
        scroll_token => scroll_token
      }

      # TODO: possibly add gzip encoding
      # headers = { 'Accept-Encoding' => 'gzip' }
      post(path: '/v5/person/search', body: body)
    end
  end
end
