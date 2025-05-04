FactoryBot.define do
    factory :project do
        name { "Test Project" }
        description { "This is a sample project description." }
        association :user
    end
end
