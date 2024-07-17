class Profile < ApplicationRecord
	has_one :profile_info, dependent: :destroy
	accepts_nested_attributes_for :profile_info

	validates :name, presence: true
	validates :github_url, presence: true, uniqueness: true
end
