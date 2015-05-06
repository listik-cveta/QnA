require 'rails_helper'

feature 'User features', %q{
        User can create question
        User can give answer on question
        User can see list of questions
        User can see question and answer
                     } do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }
  scenario 'User try to give answer on a question' do
    sign_in(user)
    visit question_path(question)
    fill_in 'Body', with: 'This is answer on a question'
    click_on 'Add answer'
    expect(page).to have_content 'This is answer on a question'
  end


  scenario 'User try to delete own answer' do
    sign_in(user)
    visit question_path(question)
    #unless question.answers.empty?
    #  expect(page).to have_selector('a', text: 'Delete answer')
    #end
    #click_on answer
    #save_and_open_page
    click_on 'Delete answer'
    expect(page).to have_content 'Your answer has deleted'

  end



   scenario 'User try to delete foreign answer' do
     sign_in(another_user)
     visit question_path(question)
     expect(page).not_to have_selector('a', text: 'Delete answer')
   end
  scenario 'User try to delete foreign answer' do
    #sign_in(another_user)
    visit question_path(question)
    expect(page).not_to have_selector('a', text: 'Delete answer')
  end

  end