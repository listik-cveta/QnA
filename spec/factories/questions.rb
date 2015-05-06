FactoryGirl.define do
  factory :question do
    title "My question"
body "My question text"
    association :user
  end
factory :invalid_question, class: "Question" do
  title nil
  body nil
end


end
