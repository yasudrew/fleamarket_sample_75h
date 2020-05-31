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
  end

end