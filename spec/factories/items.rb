FactoryBot.define do

  factory :item do
    association :category
    association :brand
    association :user
    association :shipping
    name              {"abe"}
    description       {"akfahfahfdhfko;ahf"}
    status            {"1"}
    price             {"1000"}
    fee               {"100"}
    profit            {"900"}
    buyer_id          {""}
    user_id            {"1"}

    after(:create) do |item|
      create_list(:images, 3, item: item)
  end

end