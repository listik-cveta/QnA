FactoryGirl.define do
  factory :answer do
    body "This is answer on a question"
    association :user
    association :question
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    question nil
  end

end