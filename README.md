<p align="center">
<img src="https://i.imgur.com/S7DkZtr.png" width="250" alt="People Data Labs Logo">
</p>
<h1 align="center">People Data Labs Ruby Library</h1>
<p align="center">Official Ruby client for the People Data Labs API.</p>

<p align="center">
  <a href="https://github.com/peopledatalabs/peopledatalabs-ruby">
    <img src="https://img.shields.io/badge/repo%20status-Active-limegreen" alt="Repo Status">
  </a>&nbsp;
  <a href="https://rubygems.org/gems/peopledatalabs">
    <img src="https://img.shields.io/gem/v/peopledatalabs.svg" alt="People Data Labs on RubyGems" />
  </a>&nbsp;
  <a href="https://github.com/peopledatalabs/peopledatalabs-ruby/actions/workflows/test.yaml">
    <img src="https://github.com/peopledatalabs/peopledatalabs-ruby/actions/workflows/test.yaml/badge.svg" alt="Tests Status" />
  </a>
</p>

#
This is a simple Ruby client library to access the various API endpoints provided by [People Data Labs](https://www.peopledatalabs.com/).

This library bundles up PDL API requests into simple function calls, making it easy to integrate into your projects. You can use the various [API endpoints](#endpoints) to access up-to-date, real-world data from our massive [Person](https://docs.peopledatalabs.com/docs/stats) and [Company](https://docs.peopledatalabs.com/docs/company-stats) Datasets.

## Table of Contents
- [🔧 Installation](#installation)
- [🚀 Usage](#usage)
- [🏝 Sandbox Usage](#sandbox)
- [🌐 Endpoints](#endpoints)
- [📘 Documentation](#documentation)
- [⚠️ Upgrading from v1.X.X to v2.0.0](#upgrading)

## Installation <a name="installation"></a>

1. Add this line to your application's Gemfile:

```ruby
gem 'peopledatalabs'
```

2. And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install peopledatalabs
```

3. Sign up for a [free PDL API key](https://www.peopledatalabs.com/signup)

## 🚀 Usage <a name="usage"></a>

First, add your API Key:
```ruby
Peopledatalabs.api_key = 'api_key'
```

Then, send requests to any PDL API Endpoint:

**Using Person APIs**
```ruby
# By Enrichment
Peopledatalabs::Enrichment.person(params: { phone: '4155688415' })

# By Bulk Enrichment
Peopledatalabs::Bulk.person(params: {requests: [{params: {profile: ['linkedin.com/in/seanthorne']}}, {params: {profile: ['linkedin.com/in/randrewn']}}]})

# By Search (SQL)
Peopledatalabs::Search.person(searchType: 'sql', query: "SELECT * FROM person WHERE job_company_name='people data labs'")

# By Search (Elasticsearch)
Peopledatalabs::Search.person(searchType: 'elastic', query: {"query": {"term": {"job_company_name": "people data labs"}}})

# By PDL_ID
Peopledatalabs::Retrieve.person(person_id: 'qEnOZ5Oh0poWnQ1luFBfVw_0000')

# By Fuzzy Enrichment
Peopledatalabs::Identify.person(params: { name: 'sean thorne' })
```

**Using Company APIs**
```ruby
# By Enrichment
Peopledatalabs::Enrichment.company(params: { website: 'peopledatalabs.com' })

# By Bulk Enrichment
Peopledatalabs::Bulk.company(params: {requests: [{params: {profile: ['linkedin.com/company/peopledatalabs']}}, {params: {profile: ['linkedin.com/company/apple']}}]})

# By Search (SQL)
Peopledatalabs::Search.company(searchType: 'sql', query: "SELECT * FROM company WHERE tags='big data' AND industry='financial services' AND location.country='united states'")

# By Search (Elasticsearch)
Peopledatalabs::Search.company(searchType: 'elastic', query: {"query": "must": [{"term": {"tags": "big data"}}, {"term": {"industry": "financial services"}}, {"term": {"location_country": "united states"}}]})
```

**Using Autocomplete API**
```ruby
# Get Autocomplete Suggestions
Peopledatalabs::Autocomplete.retrieve(field: 'title', text: 'full', size: 10)
```

**Using Cleaner APIs**
```ruby
# Clean Raw Company Strings
Peopledatalabs::Cleaner.company(kind: 'name', value: 'peOple DaTa LabS')

# Clean Raw Location Strings
Peopledatalabs::Cleaner.location(value: '455 Market Street, San Francisco, California 94105, US')

# Clean Raw School Strings
Peopledatalabs::Cleaner.school(kind: 'name', value: 'university of oregon')
```

**Using Job Title Enrichment API**
```ruby
# Get Job Title Enrichment
Peopledatalabs::JobTitle.retrieve(job_title: 'data scientist')
```

**Using Skill Enrichment API**
```ruby
# Get Skill Enrichment
Peopledatalabs::Skill.retrieve(skill: 'c++')
```

**Using IP Enrichment API**
```ruby
# Get IP Enrichment
Peopledatalabs::Enrichment.ip(ip: '72.212.42.169')
```

## 🏝 Sandbox Usage <a name="sandbox"></a>
```ruby
# To enable sandbox usage, use the following flag
Peopledatalabs.sandbox = true
```

## 🌐 Endpoints <a name="endpoints"></a>

**Person Endpoints**
| API Endpoint | peopledatalabs Function |
|-|-|
| [Person Enrichment API](https://docs.peopledatalabs.com/docs/enrichment-api) | `Peopledatalabs::Enrichment.person(...params)` |
| [Person Bulk Person Enrichment API](https://docs.peopledatalabs.com/docs/bulk-enrichment-api) | `Peopledatalabs::Bulk.person(...records)` |
| [Person Search API](https://docs.peopledatalabs.com/docs/search-api) | `Peopledatalabs::Search.person(...params)` |
| [Person Retrieve API](https://docs.peopledatalabs.com/docs/person-retrieve-api) | `Peopledatalabs::Autocomplete.retrieve(...params)` |
| [Person Identify API](https://docs.peopledatalabs.com/docs/identify-api) | `Peopledatalabs::Identify.person(...params)` |

**Company Endpoints**
| API Endpoint | peopledatalabs Function |
|-|-|
| [Company Enrichment API](https://docs.peopledatalabs.com/docs/company-enrichment-api) | `Peopledatalabs::Enrichment.company(...params)` |
| [Company Bulk Enrichment API](https://docs.peopledatalabs.com/docs/bulk-company-enrichment-api) | `Peopledatalabs::Bulk.company(...params)` |
| [Company Search API](https://docs.peopledatalabs.com/docs/company-search-api) | `Peopledatalabs::Search.company(...params)` |

**IP Endpoints**
| API Endpoint | peopledatalabs Function |
|-|-|
| [IP Enrichment API](https://docs.peopledatalabs.com/docs/ip-enrichment-api) | `Peopledatalabs::Enrichment.ip(...params)` |

**Supporting Endpoints**
| API Endpoint | peopledatalabs Function |
|-|-|
| [Autocomplete API](https://docs.peopledatalabs.com/docs/autocomplete-api) | `Peopledatalabs::Autocomplete.retrieve(...params)` |
| [Company Cleaner API](https://docs.peopledatalabs.com/docs/cleaner-apis#companyclean) | `Peopledatalabs::Cleaner.company(...params)` |
| [Location Cleaner API](https://docs.peopledatalabs.com/docs/cleaner-apis#locationclean) | `Peopledatalabs::Cleaner.location(...params)` |
| [School Cleaner API](https://docs.peopledatalabs.com/docs/cleaner-apis#schoolclean) | `Peopledatalabs::Cleaner.school(...params)` |
| [Job Title Enrichment API](https://docs.peopledatalabs.com/docs/job-title-enrichment-api) | `Peopledatalabs::JobTitle.retrieve(...params)` |
| [Skill Enrichment API](https://docs.peopledatalabs.com/docs/skill-enrichment-api) | `Peopledatalabs::Skill.retrieve(...params)` |

## 📘 Documentation <a name="documentation"></a>

All of our API endpoints are documented at: https://docs.peopledatalabs.com/

These docs describe the supported input parameters, output responses and also provide additional technical context.

As illustrated in the [Endpoints](#endpoints) section above, each of our API endpoints is mapped to a specific method in the peopledatalabs class.  For each of these class methods, **all function inputs are mapped as input parameters to the respective API endpoint**, meaning that you can use the API documentation linked above to determine the input parameters for each endpoint.

As an example:

The following is **valid** because `name` is a [supported input parameter to the Person Identify API](https://docs.peopledatalabs.com/docs/identify-api-reference#input-parameters):
```ruby
Peopledatalabs::Identify.person(params: { name: 'sean thorne' })
```

Conversely, this would be **invalid** because `fake_parameter` is not an input parameter to the Person Identify API:
```ruby
Peopledatalabs::Identify.person(params: { fake_parameter: 'anything' })
```

## ⚠️ Upgrading from v1.X.X to v2.0.0 <a name="upgrading"></a>

Bulk Person and Person Search now use .person instead of .people

i.e. Peopledatalabs::Bulk.people(...records) is now Peopledatalabs::Bulk.person(...records)
<br />i.e. Peopledatalabs::Search.people(...params) is now Peopledatalabs::Search.person(...params)
