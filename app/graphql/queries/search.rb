class Queries::Search < Queries::BaseQuery
  type [ Types::CompanyType ], null: false

  argument :description, String, required: false
  argument :company_name, String, required: false
  argument :locations_hiring_in, String, required: false
  argument :roles_hiring_for, String, required: false

  def resolve(args)
    Company.search(args)
  end
end