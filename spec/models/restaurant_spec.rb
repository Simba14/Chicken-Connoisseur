require 'rails_helper'

describe Restaurant, type: :model do

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless has a unique name' do
    user = User.create(email: 'test@123.com', password: '123456', password_confirmation: '123456')
    Restaurant.create(name: 'Moes Tavern', user_id: user.id)
    restaurant = Restaurant.new(name: 'Moes Tavern')
    expect(restaurant).to have(1).error_on(:name)
  end

  it { should belong_to(:user) }
end
