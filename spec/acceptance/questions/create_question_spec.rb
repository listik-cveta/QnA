require_relative '../acceptance_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authorized user
  I want to be able to ask questions
} do

  given(:user) { create(:user) }

  scenario 'Authorized user creates question' do

    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
    click_on 'Create'
    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Non-authorized user tries to create question' do
    visit questions_path
    expect(page).not_to have_content 'Ask question'
  end


end