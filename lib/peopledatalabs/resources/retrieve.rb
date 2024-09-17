# frozen_string_literal: true

module Peopledatalabs
  class Retrieve < APIResource
    def self.person(person_id:, pretty: false, updated_title_roles: false)
      headers = {
        'Accept-Encoding' => 'gzip',
        'User-Agent' => 'PDL-RUBY-SDK',
      }
      get(path: "/v5/person/retrieve/#{person_id}", headers: headers, params: { 'pretty' => pretty, 'updated_title_roles' => updated_title_roles })
    end
  end
end
