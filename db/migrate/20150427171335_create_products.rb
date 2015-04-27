class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :user_id
      t.string :name
      t.integer :starting_price_cents
      t.text :description

      t.timestamps null: false
    end
  end
end
