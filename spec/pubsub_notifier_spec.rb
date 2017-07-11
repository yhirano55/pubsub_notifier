require "spec_helper"

RSpec.describe PubsubNotifier do
  let(:user)   { User.new }
  let(:member) { Member.new }

  describe "#publish_notifier" do
    it "calls success method on subscribed classes" do
      expect_any_instance_of(AdminNotifier).to receive(:success).once
      expect_any_instance_of(UserNotifier).to receive(:success).once
      user.broadcast(:success)
    end

    it "calls logger methods on subscribed classes" do
      expect_any_instance_of(Logger).to receive(:debug).exactly(4).times
      member.broadcast(:success)
      member.broadcast(:failure)
    end

    it "calls only_admin methods on subscribed classes" do
      expect_any_instance_of(AdminNotifier).to receive(:only_admin).once
      expect_any_instance_of(UserNotifier).not_to receive(:only_admin).once
      member.broadcast(:only_admin)
    end

    it "calls only_user methods on subscribed classes" do
      expect_any_instance_of(UserNotifier).to receive(:only_user).once
      expect_any_instance_of(AdminNotifier).not_to receive(:only_user).once
      member.broadcast(:only_user)
    end
  end
end
