class CreateLtiDockers < ActiveRecord::Migration
  def change
    create_table :lti_dockers do |t|
      t.text :host
      t.integer :port
      t.string :pw
      t.string :appname
      t.text :appdesc
      t.boolean :expired
      t.string :username
      t.string :userId
      t.string :userEmail
      t.string :string

      t.timestamps
    end
  end
end
