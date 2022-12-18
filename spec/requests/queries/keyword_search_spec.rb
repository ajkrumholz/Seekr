require 'rails_helper'

RSpec.describe 'keyword search query' do
  describe 'happy path' do
    it 'searches companyName and description for keyword' do
      def query(keyword)
        <<~GQL
          {
            keywordSearch(keyword: "#{keyword}") {
              companyName
              description
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

      expect(result[:data][:keywordSearch].size).to eq 3
    end
  end

  describe 'sad path' do
    describe 'when nothing matches the keyword' do
      it 'returns an empty array' do
        def query(keyword)
          <<~GQL
            {
              keywordSearch(keyword: "#{keyword}") {
                companyName
                description
              }
            }
          GQL
        end

        create_list(:company, 10)

        post "/graphql", params: { query: query("$(@FJ#!") }
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:data][:keywordSearch].size).to eq 0
      end
    end

    describe 'when keyword is missing' do
      it 'returns an error' do
        def query
          <<~GQL
            {
              keywordSearch {
                companyName
                description
              }
            }
          GQL
        end

        create_list(:company, 10)

        post "/graphql", params: { query: query }
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:errors].first[:message]).to eq "Field 'keywordSearch' is missing required arguments: keyword"
      end
    end
  end
end