class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :category_id
      t.string :product_name
      t.string :description
      t.string :image_one
      t.integer :price

      t.timestamps
    end
  end
end
