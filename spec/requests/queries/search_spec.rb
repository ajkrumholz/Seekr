require 'rails_helper'

RSpec.describe 'search query' do
  describe 'happy paths' do
    it 'can search by multiple column values' do
      create_list(:company, 5, company_name: "travel", roles_hiring_for: "backend" )
      create(:company, company_name: "travel", roles_hiring_for: "frontend")

      def query
        <<~GQL
          {
            search(companyName: "travel", rolesHiringFor: "backend") {
              companyName
              description
            }
          }
        GQL
      end

      post "/graphql", params: { query: query }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(Company.count).to eq 6
      expect(result[:data][:search].size).to eq 5
    end
  end

  describe 'sad paths' do
    describe 'when no companies match' do
      it 'returns an empty array' do
        create_list(:company, 5, company_name: "travel", roles_hiring_for: "backend")

        def query
          <<~GQL
          {
            search(companyName: "entertainment", rolesHiringFor: "frontend") {
              companyName
              description
            }
          }
          GQL
        end

        post "/graphql", params: { query: query }
        result = JSON.parse(response.body, symbolize_names: true)

        expect(Company.count).to eq 5

        expect(result[:data][:search]).to be_empty
      end
    end
  end
end