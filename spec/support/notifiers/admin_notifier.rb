class AdminNotifier < ApplicationNotifier
  def success(recipient)
    notify_success("#{recipient.class}##{__method__}")
  end

  def failure(recipient)
    notify_failure("#{recipient.class}##{__method__}")
  end

  def only_admin(recipient)
    notify_success("#{recipient.class}##{__method__}")
  end
end
