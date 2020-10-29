class RenamePasswqrdColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :passwprd, :password
  end
end
