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

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        user = User.create(email: 'test@123.com', password: '123456', password_confirmation: '123456')
        restaurant = Restaurant.create(name: 'Sams Beef', user_id: user.id)
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end

    context '1 review' do
      it 'returns that rating' do
        user = User.create(email: 'test@123.com', password: '123456', password_confirmation: '123456')
        restaurant = Restaurant.create(name: 'Sams Beef', user_id: user.id)
        restaurant.reviews.create(rating: 4, user_id: user.id)
        expect(restaurant.average_rating).to eq 4
      end
    end

    context '2 reviews' do
      it 'returns the average rating' do
        user = User.create(email: 'test@123.com', password: '123456', password_confirmation: '123456')
        restaurant = Restaurant.create(name: 'Sams Beef', user_id: user.id)
        restaurant.reviews.create(rating: 2, user_id: user.id)
        user = User.create(email: 'test2@123.com', password: '123456', password_confirmation: '123456')
        restaurant.reviews.create(rating: 4, user_id: user.id)
        expect(restaurant.average_rating).to eq 3
      end
    end
  end
end
