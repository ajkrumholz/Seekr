module Types
  class CompanyType < Types::BaseObject
    field :id, ID, null: false
    field :company_name, String
    field :description, String
    field :hiring_link, String
    field :roles_hiring_for, String
    field :locations_hiring_in, String
    field :one_nice_thing, String
    field :comments, String
  end
end