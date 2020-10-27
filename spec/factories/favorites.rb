FactoryBot.define do
  factory :favorite do
    association :user
    association :blog
  end
end
