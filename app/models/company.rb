class Company < ApplicationRecord
  def self.keyword_search(keyword)
    where("company_name ILIKE ? OR description ILIKE ?", "%#{keyword}%", "%#{keyword}%")
  end

  def self.name_search(name)
    where("company_name ILIKE ?", "%#{name}%")
  end

  def self.search(args)
    found_companies = Company.all
    args.each do |column_name, value|
      if Company.column_names.include?(column_name.to_s)
        found_companies = found_companies.where("#{column_name} ILIKE ?", "%#{value}%")
      end
    end
    found_companies
  end
end