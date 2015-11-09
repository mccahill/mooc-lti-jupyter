class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :displayName
      t.string :netid
      t.string :dukeId

      t.timestamps
    end
  end
end
