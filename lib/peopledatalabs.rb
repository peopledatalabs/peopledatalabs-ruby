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
require 'peopledatalabs/resources/jobtitle'
require 'peopledatalabs/resources/skill'


# gem build peopledatalabs.gemspec
# gem install ./peopledatalabs-2.1.0.gem
# irb
# require 'peopledatalabs'
# rake spec PDL_API_KEY=API_KEY

# Usage
# First set api key
# Peopledatalabs.api_key = 'api_key'
# # Can set sandbox to true. Defaults to false
# # Peopledatalabs.sandbox = false
# Examples Calls:
# Peopledatalabs::Cleaner.company(kind: 'website', value: 'peopledatalabs.com')
# Peopledatalabs::Cleaner.school(kind: 'profile', value: 'linkedin.com/school/ucla')
# Peopledatalabs::Cleaner.location(value: '239 NW 13th Ave, Portland, Oregon 97209, US')
# Peopledatalabs::Search.person(searchType: 'elastic', query: {"query": {"term": {"job_company_name": "people data labs"}}})
# Peopledatalabs::Search.person(searchType: 'sql', query: "SELECT * FROM person WHERE job_company_name='people data labs'")
# Peopledatalabs::Autocomplete.retrieve(field: 'school', text: 'university of michigan')
# Peopledatalabs::Enrichment.person(params: { name: 'Jennifer C. Jackson', locality: 'Boise' })
# Peopledatalabs::Bulk.person(params: {requests: [{params: {profile: ['linkedin.com/in/seanthorne']}}, {params: {profile: ['linkedin.com/in/randrewn']}}]})
# Peopledatalabs::Enrichment.company(params: { name: 'Google, Inc.', ticker: 'GOOGL'})
# Peopledatalabs::Identify.person(params: { name: 'Jennifer C. Jackson', location: 'Medford, OR USA' })
# Peopledatalabs::Retrieve.person(person_id: 'qEnOZ5Oh0poWnQ1luFBfVw_0000')
# Peopledatalabs::Search.company(searchType: 'sql', size: 10, query: "SELECT * FROM company WHERE tags='big data' AND industry='financial services' AND location.country='united states';")
# Peopledatalabs::Search.company(searchType: 'elastic', size: 10, query: { query: { bool: { must: [{term: {location_country: 'mexico'}}, {term: {job_title_role: 'health'}}, {exists: {field: 'phone_numbers'}}]}}})
# Peopledatalabs::JobTitle.retrieve(job_title: 'data scientist')
# Peopledatalabs::Skill.retrieve(skill: 'c++')
# Peopledatalabs::Enrichment.ip(ip: '72.212.42.169')

module Peopledatalabs
  class Error < StandardError; end

  @config = Peopledatalabs::Configuration.setup

  class << self
    extend Forwardable

    attr_reader :config

    def_delegators :@config, :api_key, :api_key=
    def_delegators :@config, :sandbox, :sandbox=
    def_delegators :@config, :read_timeout, :read_timeout=
    def_delegators :@config, :api_base
  end
end




