class CreateLtiUserSessions < ActiveRecord::Migration
  def change
    create_table :lti_user_sessions do |t|
      t.string :username
      t.string :userId
      t.string :userEmail
      t.string :destination
      t.string :action
      t.string :notes

      t.timestamps
    end
  end
end
