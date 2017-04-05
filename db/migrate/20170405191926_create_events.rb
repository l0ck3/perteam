class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :teams_count

      t.timestamps
    end
  end
end
