require_relative '../acceptance_helper'

feature 'Answer features', %q{
        User can create question
        User can give answer on question
        User can see list of questions
        User can see question and answer
                     } do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }
  given(:answers) { create_list(:answer, 2, user: user, question: question) }
  given(:best_answer) { create(:answer, user: user, question: question, best: true) }


  scenario 'User try to give answer on a question', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Body', with: 'This is answer on a question'
    click_on 'Add answer'
    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'This is answer on a question'
    end
  end

  scenario 'Another user try to give answer on a question', js: true do
    sign_in(another_user)
    visit question_path(question)
    fill_in 'Body', with: 'This is answer on a question'
    click_on 'Add answer'
    expect(page).to have_content 'This is answer on a question'
  end


  scenario 'User try to delete own answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete answer'
    expect(page).to_not have_content answer.body

  end


  scenario 'User try to delete foreign answer', js: true do
    sign_in(another_user)
    visit question_path(question)
    expect(page).not_to have_selector('a', text: 'Delete answer')
  end


  scenario 'User try to create invalid answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Add answer'
    expect(page).to have_content "Body is too short (minimum is 5 characters)"
  end

end