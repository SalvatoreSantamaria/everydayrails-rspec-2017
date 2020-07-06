FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name "Kuma"
    last_name  "Dog"
    #A sequence increments and injects a counter into the attribute that needs to be unique, 
    #each time it creates a new object from a factory.
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "dottle-nouveau-pavilion-tights-furze"
    sequence(:id){ |n| n}
  end
end
