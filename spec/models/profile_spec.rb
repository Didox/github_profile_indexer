# spec/models/profile_spec.rb
require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      profile = FactoryBot.build(:profile)
      expect(profile).to be_valid
    end

    it 'is not valid without a name' do
      profile = FactoryBot.build(:profile, name: nil)
      expect(profile).to_not be_valid
      expect(profile.errors[:name]).to include("can't be blank")
    end

    it 'is not valid without a github_url' do
      profile = FactoryBot.build(:profile, github_url: nil)
      expect(profile).to_not be_valid
      expect(profile.errors[:github_url]).to include("can't be blank")
    end

    it 'is not valid with a duplicate github_url' do
      profile1 = FactoryBot.create(:profile, github_url: "https://github.com/example")
      profile2 = FactoryBot.build(:profile, github_url: "https://github.com/example")
      expect(profile2).to_not be_valid
      expect(profile2.errors[:github_url]).to include("has already been taken")
    end
  end

  describe 'associations' do
    it { should have_one(:profile_info).dependent(:destroy) }
    it { should accept_nested_attributes_for(:profile_info) }
  end
end
