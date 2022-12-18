require 'rails_helper'

RSpec.describe 'company query' do
  describe 'happy path' do
    it 'returns information about company with id X' do
      def query(company_id)
        <<~GQL
          {
            company(id: #{company_id}) {
              companyName
              description
              rolesHiringFor
            }
          }
        GQL
      end

      company = create :company

      post "/graphql", params: { query: query(company.id) }
      result = JSON.parse(response.body, symbolize_names: true)
      
      expect(result).to have_key(:data)

      company = result[:data][:company]
      expect(company).to have_key(:companyName)
      expect(company[:companyName]).to be_a String
      expect(company).to have_key(:description)
      expect(company[:description]).to be_a String
      expect(company).to have_key(:rolesHiringFor)
      expect(company[:rolesHiringFor]).to be_a String
    end
  end
end