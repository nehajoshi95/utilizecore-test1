class CreateUserrecords < ActiveRecord::Migration[6.1]
  def change
    create_table :userrecords do |t|
      t.string :file

      t.timestamps
    end
  end
end