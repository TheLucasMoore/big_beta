class AddGradeIdToClimbs < ActiveRecord::Migration[5.2]
  def change
    add_column :climbs, :grade_id, :integer
  end
end
