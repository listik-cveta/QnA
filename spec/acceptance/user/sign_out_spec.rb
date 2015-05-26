require_relative '../acceptance_helper'

feature 'User features', %q{
        User can sign out
        User can give answer
                     } do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'User try to sign out' do

    sign_in(user)

    visit questions_path
    click_on 'Logout'

    expect(page).to have_content 'Signed out successfully.'
  end

end