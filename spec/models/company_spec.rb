require 'rails_helper'

RSpec.describe Company, type: :model do
  it 'exists' do
    company = create :company

    expect(company).to be_a described_class 
    expect(company.company_name).to be_a String
    expect(company.description).to be_a String
    expect(company.hiring_link).to be_a String
    expect(company.roles_hiring_for).to be_a String
    expect(company.locations_hiring_in).to be_a String
    expect(company.one_nice_thing).to be_a String
    expect(company.comments).to be_a String
  end

  describe 'class methods' do
    it 'returns companies that match a keyword in description or name' do
      company_1 = create(:company, company_name: "travel")
      company_2 = create(:company, company_name: "travel boss")
      company_3 = create(:company, description: "travel")
      company_4 = create(:company, company_name: "nomatch", description: "nomatch")

      result = Company.keyword_search("travel")
      
      expect(result).to include(company_1, company_2, company_3)
      expect(result).not_to include(company_4)
    end
  end
end