require_relative '../acceptance_helper'

feature 'User features', %q{
        User can create question
        User can give answer on question
        User can see list of questions
        User can see question and answer
                     } do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user, title: 'Title is title') }


  scenario 'User try to delete own question' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete question'
    expect(current_path).to eq questions_path
    expect(page).not_to have_content 'Title is title'
  end
  scenario 'User try to delete foreign question' do
    sign_in(another_user)
    visit question_path(question)
    expect(page).not_to have_selector('a', text: 'Delete question')
  end

  scenario 'Try to delete foreign question' do
    visit question_path(question)
    expect(page).not_to have_selector('a', text: 'Delete question')

  end
end
