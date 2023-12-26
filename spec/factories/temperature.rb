FactoryBot.define do
  factory :temperature, class: Temperature do
    temperature { rand(-50.0..50.0).round(1) }
    current { true }
    epoch_time { Time.current.to_i }

    trait :historical do
      current { false }
    end
  end
end
