require 'csv'

namespace :csv_load do
  desc 'Read CSV File Hiring Companies'
  task hiring_companies: :environment do
    hiring_companies = Rails.root.join("db", "data", "hiring_companies.csv")

    CSV.foreach(hiring_companies, headers: true, header_converters: :symbol) do |company|

      company_hash = { 
        company_name: company[:company_name],
        description: company[:what_does_the_company_do_in_one_sentence],
        hiring_link: company[:link_to_positions_hiring_for],
        roles_hiring_for: company[:roles_hiring_for],
        locations_hiring_in: company[:locations_hiring_in],
        one_nice_thing: company[:if_you_work_in_this_company_what_is_one_thing_you_like_about_this_place],
        comments: company[:any_other_comments]
      }
      if !company_hash[:company_name].blank?
        Company.create!(company_hash)
      end
    end
    # ActiveRecord::Base.connection.reset_pk_sequence!('companies')
  end
end