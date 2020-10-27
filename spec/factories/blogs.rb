FactoryBot.define do
  factory :blog do
    association :user
    sequence(:title) {|i| "Title#{i}" }
    body { 'Test Body' }

    trait :blog_with_comment do
      after(:create) do | blog |
        3.times { create(:comment, blog: blog) }
      end
    end

    trait :with_image do
     image { File.new("#{Rails.root}/spec/factories/images/test.png") }
    end
  end
end
