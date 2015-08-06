class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :event_product_id
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
