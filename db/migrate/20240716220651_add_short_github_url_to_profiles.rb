class AddShortGithubUrlToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :short_github_url, :string
  end
end
