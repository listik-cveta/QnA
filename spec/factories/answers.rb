FactoryGirl.define do
  factory :answer do
    body "MyString"
text "MyString"
  end

  factory :invalid_answer, class: "Answer" do
    body nil
  end

end
