FactoryBot.define do

  factory :shipping do
    burden              {"1"}
    area                {"1"}
    day                 {"1"}
    after(:create) do |user|
      create_list(:items, 3, user: user)
  end

end