class AddUserContibuteIdToContributors < ActiveRecord::Migration
  def change
    add_column :contributors, :user_contribute_id, :integer
  end
end
