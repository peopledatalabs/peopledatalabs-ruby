RSpec.describe Peopledatalabs do

  let(:email) { 'varun@peopledatalabs.com' }

  it "has a version number" do
    expect(Peopledatalabs::VERSION).not_to be nil
  end

  it "has an api value" do
    expect(Peopledatalabs.api_key).not_to be nil
  end

  describe 'person enrichment' do
    it "should return person record for a email" do
      result = Peopledatalabs::Enrichment.person(params: { email: email })
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should return person record for a email with updated title roles" do
      result = Peopledatalabs::Enrichment.person(params: { email: email, updated_title_roles: true })
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should error" do
      result = Peopledatalabs::Enrichment.person(params: {})
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end
  end

  describe 'person identity' do
    it "should return person record for a email" do
      result = Peopledatalabs::Identify.person(params: { email: email })
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should error" do
      result = Peopledatalabs::Identify.person(params: {})
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end
  end

  describe 'person bulk' do
    let(:records) {
      {
        requests: [
          {
            params: {
              profile: ['linkedin.com/in/seanthorne'],
            },
          },
          {
            params: {
              profile: ['linkedin.com/in/randrewn'],
            },
          },
        ],
      }
    }

    it "should return person records" do
      result = Peopledatalabs::Bulk.person(params: records)
      expect(result['items'].length).to eq(2)
      expect(result['items']).to be_an_instance_of(Array)
    end

    it "should error" do
      result = Peopledatalabs::Bulk.person(params: {})
      expect(result['status']).to eq(400)
    end
  end

  describe 'person search' do

    let(:elastic){
      {
        query: {
          bool: {
            must: [
              { term: { location_country: 'mexico' } },
              { term: { job_title_role: 'health' } },
              { exists: { field: 'phone_numbers' } },
            ]
          }
        }
      }
    }
    let(:size){ 10 }

    it "should return person record for a sql" do
      result = Peopledatalabs::Search.person(searchType: 'sql', size: size,
                                             query: "SELECT * FROM person WHERE location_country='mexico' AND job_title_role='health'AND phone_numbers IS NOT NULL;")
      expect(result['status']).to eq(200)
      expect(result['data'].length).to eq([result['total'], size].min)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should return person record for a elastic" do
      result = Peopledatalabs::Search.person(searchType: 'elastic', size: size, query: elastic)
      expect(result['status']).to eq(200)
      expect(result['data'].length).to eq([result['total'], size].min)
      expect(result).to be_an_instance_of(Hash)
    end


    it "should error" do
      result = Peopledatalabs::Search.person(searchType: nil, size: 10, query: nil)

      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end
  end


  describe 'person retrieve' do
    it "should return person record for an id" do
      result = Peopledatalabs::Retrieve.person(person_id: 'qEnOZ5Oh0poWnQ1luFBfVw_0000')
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should error" do
      result = Peopledatalabs::Retrieve.person(person_id: nil)
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end
  end


  describe 'company enrichment' do
    it "should return company record for a website" do
      result = Peopledatalabs::Enrichment.company(params: { website: 'peopledatalabs.com' })
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should error" do
      result = Peopledatalabs::Enrichment.company(params: {})
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end
  end

  describe 'company bulk' do
    let(:records) {
      {
        requests: [
          {
            params: {
              profile: ['linkedin.com/company/peopledatalabs'],
            },
          },
          {
            params: {
              profile: ['linkedin.com/company/apple'],
            },
          },
        ],
      }
    }

    it "should return company records" do
      result = Peopledatalabs::Bulk.company(params: records)
      expect(result['items'].length).to eq(2)
      expect(result['items']).to be_an_instance_of(Array)
    end

    it "should error" do
      result = Peopledatalabs::Bulk.company(params: {})
      expect(result['status']).to eq(400)
    end
  end

  describe 'company search' do

    let(:elastic){
      {
        query: {
          bool: {
            must: [
              { term: { website: 'peopledatalabs.com' } },
            ]
          }
        }
      }
    }
    let(:size) { 10 }

    it "should return company record for a sql" do
      result = Peopledatalabs::Search.company(searchType: 'sql', size: size, query: "SELECT * FROM company WHERE tags='big data' AND industry='financial services' AND location.country='united states';")
      expect(result['status']).to eq(200)
      expect(result['data'].length).to eq([result['total'], size].min)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should return company record for a elastic" do
      result = Peopledatalabs::Search.company(searchType: 'elastic', size: size, query: elastic)
      expect(result['status']).to eq(200)
      expect(result['data'].length).to eq([result['total'], size].min)
      expect(result).to be_an_instance_of(Hash)
    end


    it "should error" do
      result = Peopledatalabs::Search.company(searchType: nil, size: 10, query: nil)
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end
  end

  describe 'autocomplete' do
    it "should return autocomplete record" do
      result = Peopledatalabs::Autocomplete.retrieve(field: 'skill', text: 'c++', size: 10)
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should error" do
      result = Peopledatalabs::Autocomplete.retrieve(field: nil)
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end
  end

  describe 'jobtitle' do
    it "should return jobtitle record" do
      result = Peopledatalabs::JobTitle.retrieve(job_title: 'data scientist')
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should error" do
      result = Peopledatalabs::JobTitle.retrieve(job_title: nil)
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end
  end

  describe 'skill' do
    it "should return skill record" do
      result = Peopledatalabs::Skill.retrieve(skill: 'c++')
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should error" do
      result = Peopledatalabs::Skill.retrieve(skill: nil)
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end
  end

  describe 'ip' do
    it "should return ip record" do
      result = Peopledatalabs::Enrichment.ip(ip: '72.212.42.169')
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
      expect(result['data']['company']).to be_an_instance_of(Hash)
    end

    it "should return ip record with location" do
      result = Peopledatalabs::Enrichment.ip(ip: '72.212.42.169', return_ip_location: true)
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
      expect(result['data']['ip']['location']).to be_an_instance_of(Hash)
    end

    it "should return ip record with metadata" do
      result = Peopledatalabs::Enrichment.ip(ip: '72.212.42.169', return_ip_metadata: true)
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
      expect(result['data']['ip']['metadata']).to be_an_instance_of(Hash)
    end

    it "should return ip record with person" do
      result = Peopledatalabs::Enrichment.ip(ip: '72.212.42.169', return_person: true)
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
      expect(result['data']['person']).to be_an_instance_of(Hash)
    end

    it "should return ip record with unmatched" do
      result = Peopledatalabs::Enrichment.ip(ip: '72.212.42.168', return_if_unmatched: true, return_ip_location: true)
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
      expect(result['data']['ip']['location']).to be_an_instance_of(Hash)
    end

    it "should return ip record with very high confidence" do
      result = Peopledatalabs::Enrichment.ip(ip: '72.212.42.168', return_if_unmatched: true, return_ip_location: true, min_confidence: 'very high')
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
      expect(result['data']['ip']['location']).to be_an_instance_of(Hash)
    end

    it "should error" do
      result = Peopledatalabs::Enrichment.ip(ip: nil)
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end
  end

  describe 'cleaner apis' do
    it "it should return company cleaner records" do
      result = Peopledatalabs::Cleaner.company(kind: 'name', value: 'twitter')
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
    end

    it "company cleaner should error" do
      result = Peopledatalabs::Cleaner.company(kind: nil, value: nil)
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end

    it "it should return location cleaner records" do
      result = Peopledatalabs::Cleaner.location(value: '455 Market Street, San Francisco, California 94105, US')
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
    end

    it "location cleaner should error" do
      result = Peopledatalabs::Cleaner.location(value: nil)
      expect(result['status']).to eq(404)
      expect(result).to be_an_instance_of(Hash)
    end

    it "it should return school cleaner records" do
      result = Peopledatalabs::Cleaner.school(kind: 'name', value: 'university of oregon')
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
    end

    it "location cleaner should error" do
      result = Peopledatalabs::Cleaner.school(kind: '', value: nil)
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end
  end

  describe 'sandbox' do
    it "should return sandbox person enrich record" do
      Peopledatalabs.sandbox = true
      result = Peopledatalabs::Enrichment.person(params: {  email: 'reneewillis74@aol.com' })
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should error" do
      Peopledatalabs.sandbox = true
      result = Peopledatalabs::Enrichment.person(params: {})
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should return sandbox person record for a company name" do
      Peopledatalabs.sandbox = true
      result = Peopledatalabs::Identify.person(params: { company: 'adams group' })
      expect(result['status']).to eq(200)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should error" do
      Peopledatalabs.sandbox = true
      result = Peopledatalabs::Identify.person(params: {})
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end

    let(:elastic){
      {
        query: {
          bool: {
            must: [
              { term: { location_country: 'united states' } },
            ]
          }
        }
      }
    }

    let(:size){ 10 }

    it "should return sandbox person record for a sql" do
      Peopledatalabs.sandbox = true
      result = Peopledatalabs::Search.person(searchType: 'sql', size: size, query: "SELECT * FROM person WHERE location_country='united states';")
      expect(result['status']).to eq(200)
      expect(result['data'].length).to eq([result['total'], size].min)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should return sandbox person record for a elastic" do
      Peopledatalabs.sandbox = true
      result = Peopledatalabs::Search.person(searchType: 'elastic', size: size, query: elastic)
      expect(result['status']).to eq(200)
      expect(result['data'].length).to eq([result['total'], size].min)
      expect(result).to be_an_instance_of(Hash)
    end

    it "should error" do
      Peopledatalabs.sandbox = true
      result = Peopledatalabs::Search.person(searchType: nil, size: 10, query: nil)
      expect(result['status']).to eq(400)
      expect(result).to be_an_instance_of(Hash)
    end
  end
end
