module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :companies, resolver: Queries::Companies
    field :company, resolver: Queries::Company
    field :keyword_search, resolver: Queries::KeywordSearch
    field :search_name, resolver: Queries::SearchName
    field :search, resolver: Queries::Search

  end
end
