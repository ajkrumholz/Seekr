class Queries::Companies < Queries::BaseQuery
  type [Types::CompanyType], null: true

  def resolve
    Company.all.order(company_name: :asc)
  end
end