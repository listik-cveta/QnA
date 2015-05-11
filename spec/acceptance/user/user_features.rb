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
  given!(:answers) { create_list(:answer, 3, question: question, user: author) }
  given!(:answer) { answers.at(1) }

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
    click_on answer
    click_on 'Delete answer'
    expect(page).to have_content 'Your answer has deleted'

  end

  #
  # scenario 'Another user try to delete question' do
  #   sign_in(another_user)
  #   visit question_path(question)
  #   click_on 'Delete question'
  #   expect(page).to have_content 'question.failure.not_an_author'
  # end
end