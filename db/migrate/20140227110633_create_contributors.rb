class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.integer :user_id
      t.integer :event_product_id
      t.integer :given_price

      t.timestamps
    end
  end
end
