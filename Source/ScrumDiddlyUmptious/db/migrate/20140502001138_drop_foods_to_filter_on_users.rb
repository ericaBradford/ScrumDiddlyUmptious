class DropFoodsToFilterOnUsers < ActiveRecord::Migration
  def change
    remove_column :users, :foodsToFilter
  end
end
