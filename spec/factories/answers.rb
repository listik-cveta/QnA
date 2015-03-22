FactoryGirl.define do
  factory :answer do
    body "MyAnswer"
#text "Mytext"
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    question nil
  end

end
