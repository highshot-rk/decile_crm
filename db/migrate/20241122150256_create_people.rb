class CreatePeople < ActiveRecord::Migration[8.0]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.integer :stage
      t.integer :probability
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
