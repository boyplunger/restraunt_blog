require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  context "following?" do
    subject { user.following?(other_user) }

    context 'followed' do
      before {
        user.follow(other_user.id)
      }
      it "true" do
        expect(subject).to eq(true)
      end
    end

    context 'not followed' do
      it "false" do
        expect(subject).to eq(false)
      end
    end
  end

  context "follow/unfollow" do
    it "anable to switch follow unfollow" do
      user.follow(other_user.id)
      expect(user.followings.size).to eq(1)
      expect(user.followings.first.id).to eq(other_user.id)

      user.unfollow(other_user.id)
      expect(user.followings.size).to eq(0)
    end

    it "cannnot follow own" do
      user.follow(user.id)
      expect(user.followings.size).to eq(0)
    end
  end
end
