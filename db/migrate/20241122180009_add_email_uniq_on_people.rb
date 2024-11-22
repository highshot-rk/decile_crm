class AddEmailUniqOnPeople < ActiveRecord::Migration[8.0]
  def change
    add_index :people, :email, unique: true
  end
end
