class Queries::SearchName < Queries::BaseQuery
  type [ Types::CompanyType ], null: false

  argument :name, String, required: true

  def resolve(company_name:)
    Company.where("company_name ILIKE ?", "%#{name}%")
  end
end