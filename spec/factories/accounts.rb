# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    sequence(:name){|n| "Company #{n}"}
    sequence(:subdomain){|n| "company#{n}"}
    sequence(:email){|n| "company#{n}@example.com"}
    login_url{ "http://example.com/sso/userpub" }
  end
end
