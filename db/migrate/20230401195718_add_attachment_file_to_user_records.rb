class AddAttachmentFileToUserRecords < ActiveRecord::Migration[6.1]
  def self.up
    change_table :user_records do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :user_records, :file
  end
end
