require 'rails_helper'

describe 'companies query' do
  it 'returns all companies in db' do
    def fetch_companies
      <<~GQL
        { 
          companies 
            {
              companyName
              description
              hiringLink
              rolesHiringFor
              locationsHiringIn
              oneNiceThing
              comments
            }
        }
      GQL
    end

    companies = create_list(:company, 10)
    post '/graphql', params: { query: fetch_companies }

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to have_key(:data)
    expect(result[:data]).to have_key(:companies)
    
    companies = result[:data][:companies]
    expect(companies).to be_an Array
    expect(companies.size).to eq 10

    company = companies.first
    expect(company).to have_key(:companyName)
    expect(company[:companyName]).to be_a String
    expect(company).to have_key(:description)
    expect(company[:description]).to be_a String
    expect(company).to have_key(:hiringLink)
    expect(company[:hiringLink]).to be_a String
    expect(company).to have_key(:rolesHiringFor)
    expect(company[:rolesHiringFor]).to be_a String
    expect(company).to have_key(:oneNiceThing)
    expect(company[:oneNiceThing]).to be_a String
    expect(company).to have_key(:comments)
    expect(company[:comments]).to be_a String
  end
end