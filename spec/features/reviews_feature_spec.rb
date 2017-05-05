require 'rails_helper'

feature 'reviewing' do
  before do
    sign_up
    create_restaurant
  end

  scenario 'allows user to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Reviews'
    expect(current_path).to eq '/restaurants'
    click_link 'KFC'
    expect(page).to have_content 'so so'
  end

  scenario 'displays "N/A" if no reviews' do
    expect(page).to have_content('N/A')
  end

  scenario 'displays an average rating for all reviews' do
    click_link 'Sign out'
    sign_up(email: 'sean@123.com')
    leave_review('was alright I guess', 3)
    click_link 'Sign out'
    sign_up(email: 'pete@123.com')
    leave_review('it was peng', 5)
    expect(page).to have_content 'Average rating: 4'
  end

  scenario 'displays the total number of ratings' do
    click_link 'Sign out'
    sign_up(email: 'sean@123.com')
    leave_review('was alright I guess', 3)
    click_link 'Sign out'
    sign_up(email: 'pete@123.com')
    leave_review('it was peng', 5)
    expect(page).to have_content '2 ratings'
  end
end
