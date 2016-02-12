class AddAreaProfileAgeToUser < ActiveRecord::Migration
  def change
    add_column :users, :area, :string
    add_column :users, :profile, :text
    add_column :users, :age, :integer
  end
end
