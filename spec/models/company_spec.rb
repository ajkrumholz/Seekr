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
end