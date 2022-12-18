FactoryBot.define do
  factory :company do
    company_name { Faker::Company.name + Faker::Company.suffix }
    description { Faker::Company.catch_phrase }
    hiring_link { Faker::Internet.url(path: '/careers') }
    roles_hiring_for { "Frontend Software Engineer, Backend Developer, Full-stack web development" }
    locations_hiring_in { "#{Faker::Address.city}, #{Faker::Address.city}, #{Faker::Address.city}" }
    one_nice_thing { Faker::Lorem.sentence(word_count: 8) }
    comments { Faker::Lorem.sentence(word_count: 3) }
  end
end