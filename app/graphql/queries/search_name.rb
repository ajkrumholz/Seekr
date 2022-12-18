class Queries::SearchName < Queries::BaseQuery
  type [ Types::CompanyType ], null: false

  argument :company_name, String, required: true

  def resolve(company_name:)
    Company.name_search(company_name)
  end
end