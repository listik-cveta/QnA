require_relative '../acceptance_helper'

feature 'Answer editing', %q{
In order to fix mistake
As an author of answer
I'd like be able to edit my answer
} do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }

  scenario "Unathenticated user try to edit question" do
    visit question_path(question)
    expect(page).to_not have_link 'Edit answer'
  end

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
    end
    scenario 'sees link to Edit' do
      expect(page).to have_link 'Edit'
    end
    scenario 'Author try to edit his answer', js: true do
      click_on 'Edit answer'
      within '.answer-block' do
      fill_in 'Body', with: 'edited answer'
      end
      click_on 'Update'
      expect(page).to_not have_content answer.body
      expect(page).to have_content 'edited answer'
      expect(page).to_not have_select 'textarea'
    end

  end
    scenario "Authenticated user try to edit other user's question", js: true do
      sign_in(another_user)
      visit question_path(question)
      expect(page).to_not have_link 'Edit answer'
    end
end