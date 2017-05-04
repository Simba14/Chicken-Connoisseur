def sign_up
  visit '/users/sign_up'
  fill_in 'Email', with: 'Emil@123.com'
  fill_in 'Password', with: 'testtest'
  fill_in 'Password confirmation', with: 'testtest'
  click_button 'Sign up'
  visit '/'
end

def create_restaurant
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  fill_in 'Description', with: 'Deep fried goodness'
  click_button 'Create Restaurant'
end
