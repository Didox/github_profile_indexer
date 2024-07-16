class CreateProfileInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :profile_infos do |t|
      t.string :username
      t.string :followers
      t.string :following
      t.string :stars
      t.string :contributions
      t.string :profile_image_url
      t.string :organization
      t.string :location
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
