class ProfileInfo < ApplicationRecord
  belongs_to :profile

  validates :username, presence: true, uniqueness: true
  validates :followers, :following, :stars, :contributions, :profile_image_url, presence: true
end
