class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :github_url

      t.timestamps
    end
  end
end
