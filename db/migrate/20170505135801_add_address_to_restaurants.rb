class AddAddressToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :address, :text
  end
end
