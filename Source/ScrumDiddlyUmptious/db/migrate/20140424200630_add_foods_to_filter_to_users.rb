class AddFoodsToFilterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :foodsToFilter, :string
  end
end
