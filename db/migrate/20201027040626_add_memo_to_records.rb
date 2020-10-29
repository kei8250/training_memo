class AddMemoToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :memo, :text
  end
end
