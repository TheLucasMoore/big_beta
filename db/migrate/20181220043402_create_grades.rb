class CreateGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :grades do |t|
      t.integer :system
      t.string :string_value
      t.integer :value
      t.integer :climb_type

      t.timestamps
    end
  end
end
