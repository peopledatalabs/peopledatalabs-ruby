require "forwardable"
require "http"
require "peopledatalabs/version"
require 'peopledatalabs/configuration'
require 'peopledatalabs/api_resource'
require 'peopledatalabs/resources/cleaner'
require 'peopledatalabs/resources/search'
require 'peopledatalabs/resources/autocomplete'
require 'peopledatalabs/resources/enrichment'
require 'peopledatalabs/resources/identify'
require 'peopledatalabs/resources/retrieve'
require 'peopledatalabs/resources/bulk'


# gem build peopledatalabs.gemspec
# gem install ./peopledatalabs-1.0.0.gem
# irb
# require 'peopledatalabs'

# Usage
# First set api key
# Peopledatalabs.api_key = 'api_key'
# Examples Calls:
# Peopledatalabs::Cleaner.company(kind: 'website', value: 'peopledatalabs.com')
# Peopledatalabs::Cleaner.school(kind: 'profile', value: 'linkedin.com/school/ucla')
# Peopledatalabs::Cleaner.location(value: '239 NW 13th Ave, Portland, Oregon 97209, US')
# Peopledatalabs::Search.people(searchType: 'elastic', query: {"query": {"term": {"job_company_name": "people data labs"}}})
# Peopledatalabs::Search.people(searchType: 'sql', query: "SELECT * FROM person WHERE job_company_name='people data labs'")
# Peopledatalabs::Autocomplete.retrieve(field: 'school', text: 'university of michigan')
# Peopledatalabs::Enrichment.person(params: { name: 'Jennifer C. Jackson', locality: 'Boise' })
# Peopledatalabs::Bulk.people(params: {requests: [{params: {profile: ['linkedin.com/in/seanthorne']}}, {params: {profile: ['linkedin.com/in/randrewn']}}]})
# Peopledatalabs::Enrichment.company(params: { name: 'Google, Inc.', ticker: 'GOOGL'})
# Peopledatalabs::Identify.person(params: { name: 'Jennifer C. Jackson', location: 'Medford, OR USA' })
# Peopledatalabs::Retrieve.person(person_id: 'qEnOZ5Oh0poWnQ1luFBfVw_0000')

module Peopledatalabs
  class Error < StandardError; end
  # Your code goes here...

  @config = Peopledatalabs::Configuration.setup

  class << self
    extend Forwardable

    attr_reader :config

    def_delegators :@config, :api_key, :api_key=
    def_delegators :@config, :api_base, :api_base=
    def_delegators :@config, :read_timeout, :read_timeout=
  end

  # TODO: remove
  def self.run_company(kind = 'website', value = 'peopledatalabs.com')
    Peopledatalabs.set_api
    Peopledatalabs::Cleaner.company(kind: kind, value: value)
  end

  # TODO: remove
  def self.run_school(kind = 'profile', value = 'linkedin.com/school/ucla')
    Peopledatalabs.set_api
    Peopledatalabs::Cleaner.school(kind: kind, value: value)
  end

  # TODO: remove
  def self.run_location(value = '239 NW 13th Ave, Portland, Oregon 97209, US')
    Peopledatalabs.set_api
    Peopledatalabs::Cleaner.location(value: value)
  end

  # TODO: remove
  def self.search_elastic
    Peopledatalabs.set_api

    # Works with an object as the query or a string as the query
    # Peopledatalabs::Search.people(searchType: 'elastic', query: '{"query": {"term": {"job_company_name": "people data labs"}}}')
    Peopledatalabs::Search.people(searchType: 'elastic', query: {"query": {"term": {"job_company_name": "people data labs"}}})
  end

  # TODO: remove
  def self.search_sql
    Peopledatalabs.set_api
    Peopledatalabs::Search.people(searchType: 'sql', query: "SELECT * FROM person WHERE job_company_name='people data labs'")
  end

  # TODO: remove
  def self.autocomplete(field = 'school', text = 'mich', size = 10, pretty = false)
    Peopledatalabs.set_api
    Peopledatalabs::Autocomplete.retrieve(field: field, text: text, size: size, pretty: pretty)
  end

  # TODO: remove
  def self.enrich_person
    Peopledatalabs.set_api
    Peopledatalabs::Enrichment.person(params: { name: 'Jennifer C. Jackson', locality: 'Boise' })
  end

  # TODO: remove
  def self.bulk
    Peopledatalabs.set_api

    params = {
      requests: [
        {
          params: {
            profile: ['linkedin.com/in/seanthorne']
          }
        },
        {
          params: {
            profile: ['linkedin.com/in/randrewn']
          }
        }
      ]
    };

    Peopledatalabs::Bulk.people(params: params)
  end


  # TODO: remove
  def self.enrich_company
    Peopledatalabs.set_api
    Peopledatalabs::Enrichment.company(params: { name: 'Google, Inc.', ticker: 'GOOGL'})
  end

  # TODO: remove
  def self.identify
    Peopledatalabs.set_api
    Peopledatalabs::Identify.person(params: { name: 'Jennifer C. Jackson', location: 'Medford, OR USA' })
  end

  # TODO: remove
  def self.retrieve(pretty = false)
    Peopledatalabs.set_api
    Peopledatalabs::Retrieve.person(person_id: 'qEnOZ5Oh0poWnQ1luFBfVw_0000', pretty: pretty)
  end

  # TODO: remove
  def self.set_api
    Peopledatalabs.api_key = 'my_api_key'
  end

end




