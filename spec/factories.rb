FactoryGirl.define do
  factory :user do
    name     "Jenny Peng"
    email    "pengjenny@berkeley.edu"
    password "example"
    password_confirmation "example"
  end
end