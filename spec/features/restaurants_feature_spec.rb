require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have beed added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'user is not logged in' do
    before do
      sign_up
      create_restaurant
      click_link 'Sign out'
    end

    scenario 'unable to create restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(current_path).to eq '/users/sign_in'
    end

    context 'restaurants have been added' do

      scenario 'display restaurants' do
        visit '/restaurants'
        expect(page).to have_content('KFC')
        expect(page).not_to have_content('No restaurants yet')
      end
    end

    context 'viewing restaurants' do

      scenario 'lets a user view a restaurant' do
        visit '/restaurants'
        click_link 'KFC'
        expect(page).to have_content 'KFC'
        expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
      end
    end
  end

  context 'user is logged in' do

    before do
      sign_up
      create_restaurant
    end

    context 'creating restaurants' do

      scenario 'prompts user to fill out a form then displays the new restaurant' do
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'Sams Chicken'
        click_button 'Create Restaurant'
        expect(page).to have_content 'Sams Chicken'
        expect(current_path).to eq '/restaurants'
      end

      scenario 'with an image' do
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'Roast and Toast'
        fill_in 'Description', with: 'Best wrap'
        attach_file('Image', Rails.root + "spec/fixtures/Roast.png")
        click_button 'Create Restaurant'
        expect(page).to have_css 'img'
      end

      context 'an invalid restaurant' do
        scenario 'does not let you submit a name that is too short' do
          click_link 'Add a restaurant'
          fill_in 'Name', with: 'kf'
          click_button 'Create Restaurant'
          expect(page).not_to have_css 'h2', text: 'kf'
          expect(page).to have_content 'error'
        end
      end


    end

    context 'editing restaurants' do

      scenario 'creator can edit a restaurant' do
        visit '/restaurants'
        click_link 'Edit KFC'
        fill_in 'Name', with: 'Kentucky Fried Chicken'
        fill_in 'Description', with: 'Deep fried goodness'
        click_button 'Update Restaurant'
        click_link 'Kentucky Fried Chicken'
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(page).to have_content 'Deep fried goodness'
        expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
      end

      scenario 'regular user cannot see an edit link' do
        click_link "Sign out"
        sign_up(email: 'seasn@123.com')
        expect(page).not_to have_link 'Edit KFC'
      end

      scenario 'regular user cannot edit restaurant' do
        click_link "Sign out"
        sign_up(email: 'seasn@123.com')
        visit("/restaurants/#{Restaurant.last.id}/edit")
        expect(current_path).to eq '/'
      end
    end

    context 'deleting restaurants' do

      scenario 'creator can remove a restaurant' do
        visit '/restaurants'
        click_link 'Delete KFC'
        expect(page).not_to have_content 'KFC'
        expect(page).to have_content 'Restaurant deleted successfully'
      end

      scenario 'regular user cannot see a delete link' do
        click_link "Sign out"
        sign_up(email: 'seasn@123.com')
        expect(page).not_to have_link 'Delete KFC'
      end
    end
  end

end
