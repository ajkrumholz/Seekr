require 'rails_helper'

RSpec.describe "search name query" do
  describe 'happy path' do
    it 'returns companies that match a name search' do
      def query(name)
        <<~GQL
          {
            searchName(companyName: "#{name}") {
              companyName
              description
            }
          }
        GQL
      end

      company_1 = create(:company, company_name: "travel")
      company_2 = create(:company, company_name: "travel")
      company_3 = create(:company, company_name: "travel")
      company_4 = create(:company, company_name: "nomatch")

      post "/graphql", params: { query: query("travel") }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:searchName].size).to eq 3
    end
  end

  describe 'sad path' do

  end
end