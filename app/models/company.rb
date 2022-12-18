class Company < ApplicationRecord
  def self.keyword_search(keyword)
    where("company_name ILIKE ? OR description ILIKE ?", "%#{keyword}%", "%#{keyword}%")
  end

  def self.name_search(name)
    where("company_name ILIKE ?", "%#{name}%")
  end
end