require 'rails_helper'

feature 'endorsing reviews' do
  before do
    kfc = Restaurant.create('KFC')
    kfc.reviews.create(ratings: 3, thoughts: 'It was an abomination')
  end

  scenario 'user can endorse a review, which updates the review endorsement count' do
    visit '/restaurants'
    click_link 'Endorse review'
    expect(page).to have_content('1 endorsement')
  end

end
