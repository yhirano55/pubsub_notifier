require "spec_helper"

RSpec.describe "integration test" do
  describe "broadcasting" do
    let(:user) { create(:user) }

    it "broadcast to all subscribers" do
      expect { user.broadcast(:success) }.not_to raise_error
    end

    it "broadcast to a part of subscribers" do
      expect { user.broadcast(:failure) }.not_to raise_error
    end
  end
end
