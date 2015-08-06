class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :event_name
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
