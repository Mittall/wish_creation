class AddAmountToWishes < ActiveRecord::Migration
  def change
    add_column :wishes, :amount, :integer
  end
end
