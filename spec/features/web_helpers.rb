def sign_up(email: 'Emil@123.com',
            password: 'testtest',
            password_confirmation: 'testtest')
  visit '/users/sign_up'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password_confirmation
  click_button 'Sign up'
  visit '/'
end

def create_restaurant
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  fill_in 'Description', with: 'Deep fried goodness'
  fill_in 'Address', with: '351, Ballards Lane, North Finchley, N12 8LJ'
  click_button 'Create Restaurant'
end

def leave_review(thoughts, rating)
  visit '/'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end
