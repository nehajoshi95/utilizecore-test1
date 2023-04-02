class RenameUserrecordsToUserRecords < ActiveRecord::Migration[6.1]
  def self.up
    rename_table :userrecords, :user_records
  end

  def self.down
    rename_table :user_records, :userrecords
  end
end
