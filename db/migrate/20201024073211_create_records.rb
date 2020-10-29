class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.references :workout, foreign_key: true
      t.integer :weight
      t.integer :reps

      t.timestamps
    end
  end
end
