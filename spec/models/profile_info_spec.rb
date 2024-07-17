require 'rails_helper'

RSpec.describe ProfileInfo, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      profile_info = FactoryBot.build(:profile_info)
      expect(profile_info).to be_valid
    end

    it 'is not valid without a username' do
      profile_info = FactoryBot.build(:profile_info, username: nil)
      expect(profile_info).to_not be_valid
      expect(profile_info.errors[:username]).to include("can't be blank")
    end

    it 'is not valid with a duplicate username' do
      profile = FactoryBot.create(:profile)
      profile_info1 = FactoryBot.create(:profile_info, username: 'duplicate_user', profile: profile)
      profile_info2 = FactoryBot.build(:profile_info, username: 'duplicate_user', profile: profile)
      expect(profile_info2).to_not be_valid
      expect(profile_info2.errors[:username]).to include("has already been taken")
    end

    it 'is not valid without followers' do
      profile_info = FactoryBot.build(:profile_info, followers: nil)
      expect(profile_info).to_not be_valid
      expect(profile_info.errors[:followers]).to include("can't be blank")
    end

    it 'is not valid without following' do
      profile_info = FactoryBot.build(:profile_info, following: nil)
      expect(profile_info).to_not be_valid
      expect(profile_info.errors[:following]).to include("can't be blank")
    end

    it 'is not valid without stars' do
      profile_info = FactoryBot.build(:profile_info, stars: nil)
      expect(profile_info).to_not be_valid
      expect(profile_info.errors[:stars]).to include("can't be blank")
    end

    it 'is not valid without contributions' do
      profile_info = FactoryBot.build(:profile_info, contributions: nil)
      expect(profile_info).to_not be_valid
      expect(profile_info.errors[:contributions]).to include("can't be blank")
    end

    it 'is not valid without profile_image_url' do
      profile_info = FactoryBot.build(:profile_info, profile_image_url: nil)
      expect(profile_info).to_not be_valid
      expect(profile_info.errors[:profile_image_url]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it { should belong_to(:profile) }
  end
end
