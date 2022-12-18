class Queries::Company < Queries::BaseQuery
  argument :id, ID, required: false

  type Types::CompanyType, null: true

  def resolve(id:)
    Company.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("Company doesn't exist.")
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
  end
end