class Company < ApplicationRecord
  def self.keyword_search(keyword)
    where("company_name ILIKE ? OR description ILIKE ?", "%#{keyword}%", "%#{keyword}%")
  end
end