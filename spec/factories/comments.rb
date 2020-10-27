FactoryBot.define do
  factory :comment do
    association :user
    association :blog
    sequence(:body) {|i| "Comment#{i}" }
  end
end
