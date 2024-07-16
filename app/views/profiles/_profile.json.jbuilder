json.extract! profile, :id, :name, :github_url, :created_at, :updated_at
json.url profile_url(profile, format: :json)
