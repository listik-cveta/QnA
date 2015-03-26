FactoryGirl.define do
  factory :answer do
    body "MyTextblablablablabla"
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    question nil
  end

end