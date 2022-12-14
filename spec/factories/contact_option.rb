# frozen_string_literal: true

FactoryBot.define do
  factory :contact_option do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email}
  end
end
