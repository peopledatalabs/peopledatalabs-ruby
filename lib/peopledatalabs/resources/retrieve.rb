# frozen_string_literal: true

module Peopledatalabs
  class Retrieve < APIResource
    def self.person(person_id:, pretty: false)
      # TODO: possibly add gzip encoding
      # headers = { 'Accept-Encoding' => 'gzip' }
      get(path: "/v5/person/retrieve/#{person_id}", params: { 'pretty' => pretty })
    end
  end
end
