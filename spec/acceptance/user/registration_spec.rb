require_relative '../acceptance_helper'

feature 'Unregistered user can register' do

  scenario do
    visit new_user_registration_path
    fill_in 'Email', with: 'user@blabla.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button('Sign up')

  expect(page).to have_content 'Welcome! You have signed up successfully.'
end

end