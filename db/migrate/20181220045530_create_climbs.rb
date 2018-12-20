class CreateClimbs < ActiveRecord::Migration[5.2]
  def change
    create_table :climbs do |t|
      t.integer :user_id
      t.integer :route_id
      t.integer :performance

      t.timestamps
    end
  end
end
