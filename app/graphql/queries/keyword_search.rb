class Queries::KeywordSearch < Queries::BaseQuery
  argument :keyword, String, required: true

  type [Types::CompanyType], null: true

  def resolve(keyword:)
    ::Company.keyword_search(keyword)
  end
end