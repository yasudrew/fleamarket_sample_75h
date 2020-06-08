FactoryBot.define do
  factory :sns_credential do
    provider  {'facebook'}
    uid       {'123'}
    user_id   {'1'}
  end
end