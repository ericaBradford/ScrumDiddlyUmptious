class AddToUsers < ActiveRecord::Migration
  def change
    add_column :users, :userName, :string
  end
end
