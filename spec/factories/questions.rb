FactoryGirl.define do
  factory :question do
    title "MyAnswerisfirstanswer"
body "MyTextblablablablabla"
  end
factory :invalid_question, class: "Question" do
  title nil
  body nil
end
end
