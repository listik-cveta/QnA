require_relative '../acceptance_helper'

feature 'Best answer features', %q{
        Answer can be best answer
        One of three answers is best
        Best answer is first in list with own mark

                     } do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }
  given!(:answers) { create_list(:answer, 3, user: user, question: question) }
  given!(:best_answer) { create(:answer, user: user, question: question, best: true) }

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'Best answer should be first in list' do
      within '.answers .answer-block:first-child' do
        expect(page).to have_content best_answer.body
        expect(page).to_not have_link 'Best answer'
      end
    end

    scenario 'Only one answer can be the best answer', js: :true do
      within "#answer-#{answer.id }" do
        click_on "Best answer"
      end

      within '.answers .answer-block:first-child' do
        expect(page).to have_content answer.body
        expect(page).to_not have_link 'Best answer'
      end
      within "#answer-#{ best_answer.id }" do
        expect(page).to have_link 'Best answer'
      end
    end
  end
end