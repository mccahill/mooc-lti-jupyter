class CreateLtiNonces < ActiveRecord::Migration
  def change
    create_table :lti_nonces do |t|
      t.string :nonce
      t.string :userId

      t.timestamps
    end
  end
end
