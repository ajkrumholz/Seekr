require 'rails_helper'

RSpec.describe 'company query' do
  describe 'happy path' do
    describe 'when an id is provided' do
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

    describe 'sad path' do
      describe 'when a bad id is provided' do
        it 'returns an error' do
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

          post "/graphql", params: { query: query(99999) }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:company]).to be_nil
          expect(result[:errors].first[:message]).to eq("Company doesn't exist.")
        end
      end

      describe 'when a bad attribute is requested' do
        it 'returns an error' do
          def query(company_id)
            <<~GQL
              {
                company(id: #{company_id}) {
                  companyName
                  description
                  rolesHiringFor
                  location
                }
              }
            GQL
          end

          company = create :company

          post "/graphql", params: { query: query(company.id) }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result).not_to have_key(:data)
          expect(result[:errors].first[:message]).to eq("Field 'location' doesn't exist on type 'Company'")
        end
      end

      describe 'when no id is provided' do
        it 'returns an error' do
          def query
            <<~GQL
              {
                company {
                  companyName
                  description
                  rolesHiringFor
                }
              }
            GQL
          end

          company = create :company

          post "/graphql", params: { query: query }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:errors].first[:message]).to eq("Field 'company' is missing required arguments: id")
        end
      end
    end
  end
end