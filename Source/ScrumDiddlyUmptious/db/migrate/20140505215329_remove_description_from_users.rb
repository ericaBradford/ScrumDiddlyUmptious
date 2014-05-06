class RemoveDescriptionFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :text, :description
  end
end
