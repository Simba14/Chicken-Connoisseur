require 'rails_helper'

feature 'endorsing reviews' do
  before do
    sign_up
    create_restaurant
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'It was an abomination'
    select '3', from: 'Rating'
    click_button "Leave Reviews"
    # Restaurant.last.reviews.create(rating: 3, thoughts: 'It was an abomination')
  end

  scenario 'user can endorse a review, which updates the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'KFC'
    click_link 'Endorse review'
    expect(page).to have_content('1 endorsement')
  end

end
