FactoryGirl.define do
  factory :user do
    username "yoyo"
    password "123456"
    birthday Date.new(1991,03,03)
  end

  factory :event do
    title "title"
    description "desciption"
  end
end