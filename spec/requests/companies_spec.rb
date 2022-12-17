require 'rails_helper'

describe 'companies query' do
  it 'returns all companies in db' do
    def fetch_companies
      <<~GQL
        { 
          companies 
            {

            }
        }
      GQL
    end

    companies = create_list(:company, 10)
    require 'pry'; binding.pry
    post '/graphql', params: { query: fetch_companies }
  end
end