class Queries::Company < Queries::BaseQuery
  argument :id, ID, required: false

  type Types::CompanyType, null: true

  def resolve(id:)
    Company.find(id)
  end
end