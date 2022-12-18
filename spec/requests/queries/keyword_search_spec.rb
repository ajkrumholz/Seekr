require 'rails_helper'

RSpec.describe 'keyword search query' do
  describe 'happy path' do
    it 'searches companyName and description for keyword' do
      def query(keyword)
        <<~GQL
          {
            keywordSearch(keyword: "#{keyword}") {
              company {
                companyName
                description
              }
            }
          }
        GQL
      end

      create(:company, company_name: "travel")
      create(:company, company_name: "travel boss")
      create(:company, description: "travel")
      create(:company, company_name: "nomatch", description: "nomatch")

      post "/graphql", params: { query: query("travel") }
      result = JSON.parse(response.body, symbolize_names: true)
    end
  end
end